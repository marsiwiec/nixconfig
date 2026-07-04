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

      users.users.${config.systemConstants.username} = {
        extraGroups = [ "gamemode" ];
      };

      environment.systemPackages = with pkgs; [
        mangohud
        protonplus

        # some games below
        brogue-ce
      ];

      services.flatpak.packages = lib.mkIf config.services.flatpak.enable [
        "com.heroicgameslauncher.hgl"
      ];
    };
}
