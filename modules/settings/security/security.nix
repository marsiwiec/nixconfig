{
  flake.modules.nixos.security-defaults = {
    # Modern alternatives to legacy subsystems
    networking.nftables.enable = true; # Replaces iptables
    services.dbus.implementation = "broker"; # Faster, more secure D-Bus

    security.polkit.enable = true;
  };
}
