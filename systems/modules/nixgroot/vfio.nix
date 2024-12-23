{
  pkgs,
  config,
  lib,
  ...
}: {
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
    extraModprobeConfig = "options vfio-pci ids=10de:2782,10de:22bc";
  };
}
