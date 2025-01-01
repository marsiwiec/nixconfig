{
  lib,
  config,
  pkgs,
  pkgs-stable,
  ...
}:
{
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming module with stea and heroic";
  };
  config = lib.mkIf config.gaming.enable {
    programs = {
      steam.enable = true;
      gamescope.enable = true;
      gamemode.enable = true;
    };

    environment.systemPackages = [
      pkgs-stable.heroic
      pkgs.mangohud
      pkgs.protonup-qt
      pkgs-stable.bottles
    ];
  };
}
