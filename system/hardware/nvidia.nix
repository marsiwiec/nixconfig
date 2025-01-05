{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    nvidia.enable = lib.mkEnableOption "enable NVIDIA driver for host system";
  };
  config = lib.mkIf config.nvidia.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      # nvidiaPersistenced = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
    environment.systemPackages = with pkgs; [ cudaPackages.cudatoolkit ];
  };
}
