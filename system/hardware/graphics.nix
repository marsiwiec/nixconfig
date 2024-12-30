{
  lib,
  config,
  ...
}: {
  options = {
    graphics.enable = lib.mkEnableOption "enable basic graphics support";
  };
  config = lib.mkIf config.graphics.enable {
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    hardware = {
      graphics = {
        enable = true;
      };
    };
  };
}
