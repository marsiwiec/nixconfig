{
  inputs,
  lib,
  ...
}:
let
  name = "Marcin Siwiec";
  git-username = "marsiwiec";
  git-email = "marsiwiec@users.noreply.github.com";
in
{
  flake.modules.nixos.msiwiec = {
    home-manager.users.msiwiec = {
      imports = [ inputs.self.modules.homeManager.msiwiec ];
    };
    imports = with inputs.self.modules.nixos; [
      bottles
      dank-material-shell
      containers
      flatpak
      niri
      protonvpn
      protonvpn-tailscale
      R
      rclone
      thunar
    ];

    sops.secrets.github-token-nix-config = {
      owner = "msiwiec";
      group = "users";
      mode = "0400";
    };
    users.users.msiwiec = {
      isNormalUser = true;
      description = name;
      extraGroups = [
        "wheel"
        "networkmanager"
        "kvm"
        "qemu"
        "libvirtd"
        "i2c"
      ];
    };
  };
  flake.modules.homeManager.msiwiec =
    { pkgs, lib, ... }:
    let
      protonvpnSettingsUpdater = pkgs.writers.writePython3Bin "protonvpn-tailscale-settings" { } ''
        import json
        from pathlib import Path

        settings_dir = Path.home() / ".config" / "Proton" / "VPN"
        settings_file = settings_dir / "settings.json"

        settings_dir.mkdir(parents=True, exist_ok=True)

        data = {}
        if settings_file.exists():
            try:
                with open(settings_file, "r") as f:
                    data = json.load(f)
            except (json.JSONDecodeError, OSError):
                data = {}

        data.setdefault("protocol", "wireguard")
        data["killswitch"] = 2
        data.setdefault("custom_dns", {"enabled": False, "ips": []})
        data.setdefault("ipv6", True)
        data.setdefault("anonymous_crash_reports", True)

        features = data.setdefault("features", {})
        split_tunneling = features.setdefault("split_tunneling", {})
        split_tunneling["enabled"] = True
        split_tunneling["mode"] = "exclude"

        config_by_mode = split_tunneling.setdefault("config_by_mode", {})
        exclude = config_by_mode.setdefault("exclude", {})
        exclude["mode"] = "exclude"
        exclude.setdefault("app_paths", [])
        ip_ranges = exclude.setdefault("ip_ranges", [])
        if "100.64.0.0/10" not in ip_ranges:
            ip_ranges.append("100.64.0.0/10")

        include = config_by_mode.setdefault("include", {})
        include.setdefault("mode", "include")
        include.setdefault("app_paths", [])
        include.setdefault("ip_ranges", [])

        with open(settings_file, "w") as f:
            json.dump(data, f, indent=2)
      '';
    in
    {
      imports = with inputs.self.modules.homeManager; [
        ai
        devenv
        devshells
        firefox
        git
        # ghostty
        graphics-software
        helix
        lsp
        media
        office
        positron
        print3d
        python
        shell
        spicetify
        syncthing
        wezterm
        zed
      ];

      home = {
        username = lib.mkDefault "msiwiec";
        homeDirectory = lib.mkDefault "/home/msiwiec";
        stateVersion = "26.05";
        packages = [ protonvpnSettingsUpdater ];
      };

      nix.extraOptions = ''
        !include /run/secrets/github-token-nix-config
      '';

      programs.git.settings.user = {
        name = git-username;
        email = git-email;
      };

      home.activation.protonvpn-tailscale-settings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${protonvpnSettingsUpdater}/bin/protonvpn-tailscale-settings
      '';
    };
}
