{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    gaming.enable = lib.mkEnableOption "Gaming with Steam and Heroic";
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
