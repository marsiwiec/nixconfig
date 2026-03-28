{
  flake.modules.nixos.nvidia =
    { config, lib, ... }:
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

      # hardware.nvidia-container-toolkit.enable = lib.mkIf config.virtualisation.podman.enable true;
    };
}
