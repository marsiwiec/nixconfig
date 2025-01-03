{
  lib,
  config,
  pkgs,
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

    environment.systemPackages = with pkgs; [
      heroic
      mangohud
      protonup-qt
      bottles
    ];
  };
}
