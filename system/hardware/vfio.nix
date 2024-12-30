{
  lib,
  config,
  ...
}: let
  hostname = config.networking.hostName;
in {
  options = {
    vfio.enable = lib.mkEnableOption "configuration for isolation NVIDIA GPU for passthrough into vm";
  };
  config = lib.mkIf config.vfio.enable {
    boot = {
      kernelParams = ["amd_iommu=on"];
      blacklistedKernelModules = [
        "nvidia"
        "nouveau"
      ];
      kernelModules = [
        "vfio_virqfd"
        "vfio_pci"
        "vfio_iommu_type1"
        "vfio"
      ];
      extraModprobeConfig =
        # different GPU PCIe ids depending on hostname
        if hostname == "nixgroot"
        then "options vfio-pci ids=10de:2782,10de:22bc"
        else if hostname == "labnix"
        then "options vfio-pci ids=10de:1c02,1-de:10f12"
        else [];
    };
  };
}
