{ lib, ... }:
{
  flake.modules.nixos.gaming =
    { config, pkgs, ... }:
    {
      programs = {
        steam.enable = true;
        gamescope.enable = true;
        gamemode.enable = true;
      };

      environment.systemPackages = with pkgs; [
        # heroic
        mangohud
        protonup-qt
        bottles
      ];

      services.flatpak.packages = lib.mkIf config.services.flatpak.enable [
        "com.heroicgameslauncher.hgl"
      ];
    };
}
