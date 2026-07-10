{
  flake.modules.homeManager.nixgroot-protonvpn-settings =
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
      home.packages = [ protonvpnSettingsUpdater ];

      home.activation.protonvpn-tailscale-settings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${protonvpnSettingsUpdater}/bin/protonvpn-tailscale-settings
      '';
    };
}
