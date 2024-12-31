{
  lib,
  pkgs,
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
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva
          vaapiVdpau
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
  };
}
