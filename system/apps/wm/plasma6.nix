{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    plasma6.enable = lib.mkEnableOption "enable KDE Plasma 6";
  };

  config = lib.mkIf config.plasma6.enable {
    services.desktopManager.plasma6.enable = true;
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      xwaylandvideobridge
      elisa
    ];
  };
}
