{
  lib,
  config,
  pkgs-stable,
  ...
}: {
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming module";
  };
  config = lib.mkIf config.gaming.enable {
    programs = {
      steam.enable = true;
      gamescope.enable = true;
      gamemode.enable = true;
    };

    environment.systemPackages = [
      pkgs-stable.heroic
    ];
  };
}
