{
  flake.modules.nixos.protonvpn-tailscale =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.services.tailscale;
      fwmark = "0x5253";
      tailscaleFwmark = "0x80000/0xff0000";

      dispatcherScript = pkgs.writeText "tailscale-bypass-route" ''
        #!/bin/sh
        PATH=${
          lib.makeBinPath [
            pkgs.iproute2
            pkgs.gawk
          ]
        }
        IFACE="$1"
        ACTION="$2"

        case "$ACTION" in
          up|dhcp4-change|dhcp6-change)
            case "$IFACE" in
              lo|proton*|pvpn*|tailscale*|docker*|veth*|br*|virbr*) exit 0 ;;
            esac

            GATEWAY4=$(ip -4 route show dev "$IFACE" | awk '/default/ {print $3; exit}')
            if [ -n "$GATEWAY4" ]; then
              ip -4 route flush table tailscale_bypass
              ip -4 route add default via "$GATEWAY4" dev "$IFACE" table tailscale_bypass
            fi

            GATEWAY6=$(ip -6 route show dev "$IFACE" | awk '/default/ {print $3; exit}')
            if [ -n "$GATEWAY6" ]; then
              ip -6 route flush table tailscale_bypass
              ip -6 route add default via "$GATEWAY6" dev "$IFACE" table tailscale_bypass
            fi
            ;;
        esac
      '';
    in
    lib.mkIf cfg.enable {
      environment.etc."iproute2/rt_tables.d/tailscale.conf".text = "100 tailscale_bypass\n";

      # Run tailscaled in a dedicated slice so we can match all of its sockets
      # in nftables and bypass ProtonVPN's kill-switch for the daemon.
      systemd.slices.tailscale = {
        description = "Tailscale slice";
      };

      # Mark all outgoing traffic from tailscaled so it can bypass ProtonVPN.
      # The cgroup path only exists once tailscaled has started, so add the nftables
      # rule from ExecStartPost instead of from networking.nftables.tables.
      systemd.services.tailscaled.serviceConfig = {
        Slice = "tailscale.slice";
        ExecStartPost = [
          (pkgs.writeShellScript "tailscale-bypass-nftables-start" ''
            ${pkgs.nftables}/bin/nft delete table inet tailscale-bypass 2>/dev/null || true
            ${pkgs.nftables}/bin/nft add table inet tailscale-bypass
            ${pkgs.nftables}/bin/nft add chain inet tailscale-bypass output { type filter hook output priority mangle \; }
            ${pkgs.nftables}/bin/nft add rule inet tailscale-bypass output socket cgroupv2 level 2 "tailscale.slice/tailscaled.service" meta mark set ${fwmark}
          '')
        ];
        ExecStopPost = lib.mkAfter [
          (pkgs.writeShellScript "tailscale-bypass-nftables-stop" ''
            ${pkgs.nftables}/bin/nft delete table inet tailscale-bypass 2>/dev/null || true
          '')
        ];
      };

      # Route marked packets through a dedicated table that uses the physical interface.
      systemd.services.tailscale-bypass-rules = {
        description = "Add Tailscale ProtonVPN bypass routing rules";
        after = [
          "network-pre.target"
          "nftables.service"
        ];
        wants = [ "nftables.service" ];
        before = [ "tailscaled.service" ];
        wantedBy = [ "multi-user.target" ];
        path = with pkgs; [
          iproute2
          gnugrep
        ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = ''
            ${pkgs.iproute2}/bin/ip rule del fwmark ${fwmark} to 100.64.0.0/10 lookup 52 prio 505 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip -6 rule del fwmark ${fwmark} to fd7a:115c:a1e0::/48 lookup 52 prio 505 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip rule del fwmark ${fwmark} lookup tailscale_bypass prio 1000 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip -6 rule del fwmark ${fwmark} lookup tailscale_bypass prio 1000 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip rule del fwmark ${tailscaleFwmark} to 100.64.0.0/10 lookup 52 prio 505 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip -6 rule del fwmark ${tailscaleFwmark} to fd7a:115c:a1e0::/48 lookup 52 prio 505 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip rule del fwmark ${tailscaleFwmark} lookup tailscale_bypass prio 510 2>/dev/null || true
            ${pkgs.iproute2}/bin/ip -6 rule del fwmark ${tailscaleFwmark} lookup tailscale_bypass prio 510 2>/dev/null || true
          '';
        };
        script = ''
          # Ensure custom routing table is registered
          if ! grep -qE '^100[[:space:]]+tailscale_bypass$' /etc/iproute2/rt_tables /etc/iproute2/rt_tables.d/*.conf 2>/dev/null; then
            echo "100 tailscale_bypass" >> /etc/iproute2/rt_tables
          fi

          # Tailnet traffic must still reach the tailscale0 interface, so send marked
          # packets destined for Tailnet IPs to Tailscale's own routing table.
          if ! ip rule show | grep -q "fwmark ${fwmark} to 100.64.0.0/10 lookup 52"; then
            ip rule add fwmark ${fwmark} to 100.64.0.0/10 lookup 52 prio 505
          fi
          if ! ip -6 rule show | grep -q "fwmark ${fwmark} to fd7a:115c:a1e0::/48 lookup 52"; then
            ip -6 rule add fwmark ${fwmark} to fd7a:115c:a1e0::/48 lookup 52 prio 505
          fi

          # Route other marked Tailscale traffic through the bypass table.
          if ! ip rule show | grep -q "fwmark ${fwmark} lookup tailscale_bypass"; then
            ip rule add fwmark ${fwmark} lookup tailscale_bypass prio 1000
          fi
          if ! ip -6 rule show | grep -q "fwmark ${fwmark} lookup tailscale_bypass"; then
            ip -6 rule add fwmark ${fwmark} lookup tailscale_bypass prio 1000
          fi

          # Tailscale marks all of its own traffic with fwmark 0x80000 to avoid routing
          # loops. With ProtonVPN's permanent kill-switch active, that mark would otherwise
          # be routed to the kill-switch dummy interface and dropped. Send Tailnet traffic
          # to Tailscale's own routing table (tailscale0 route) and everything else out the
          # physical interface via the bypass table.
          if ! ip rule show | grep -q "fwmark ${tailscaleFwmark} to 100.64.0.0/10 lookup 52"; then
            ip rule add fwmark ${tailscaleFwmark} to 100.64.0.0/10 lookup 52 prio 505
          fi
          if ! ip -6 rule show | grep -q "fwmark ${tailscaleFwmark} to fd7a:115c:a1e0::/48 lookup 52"; then
            ip -6 rule add fwmark ${tailscaleFwmark} to fd7a:115c:a1e0::/48 lookup 52 prio 505
          fi
          if ! ip rule show | grep -q "fwmark ${tailscaleFwmark} lookup tailscale_bypass"; then
            ip rule add fwmark ${tailscaleFwmark} lookup tailscale_bypass prio 510
          fi
          if ! ip -6 rule show | grep -q "fwmark ${tailscaleFwmark} lookup tailscale_bypass"; then
            ip -6 rule add fwmark ${tailscaleFwmark} lookup tailscale_bypass prio 510
          fi
        '';
      };

      # Keep the bypass routing table pointed at the current physical interface/gateway.
      networking.networkmanager.dispatcherScripts = lib.mkIf config.networking.networkmanager.enable [
        {
          source = dispatcherScript;
          type = "basic";
        }
      ];
    };
}
