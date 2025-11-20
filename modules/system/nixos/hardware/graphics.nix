{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    graphics.enable = lib.mkEnableOption "enable basic graphics support";
  };
  config = lib.mkIf config.graphics.enable {
    services = {
      xserver.enable = true;
      lact.enable = true;
    };

    hardware = {
      amdgpu = {
        overdrive.enable = true;
        initrd.enable = true;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
          libva
          libva-vdpau-driver
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
    };
    environment.systemPackages = with pkgs; [
      vulkan-tools
    ];
  };
}
