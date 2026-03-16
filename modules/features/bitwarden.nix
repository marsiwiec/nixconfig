{ lib, ... }:
{
  flake.modules.nixos.bitwarden =
    { config, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # bitwarden-desktop
        bitwarden-cli
      ];

      services.flatpak.packages = lib.mkIf config.services.flatpak.enable [
        "com.bitwarden.desktop"
      ];
    };
}
