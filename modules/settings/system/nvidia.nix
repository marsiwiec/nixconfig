{
  flake.modules.nixos.nvidia =
    { config, ... }:
    {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
        nvidiaSettings = true;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
      };
    };
}
