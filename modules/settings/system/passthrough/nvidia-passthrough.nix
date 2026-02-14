{ inputs, ... }:
{
  flake.modules.nixos.nvidia-passthrough =
    { config, ... }:
    {
      imports = [
        inputs.self.modules.nixos.nvidia-enable
      ];
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.looking-glass
      ];
      boot = {
        kernelParams = [ "amd_iommu=on" ];
        extraModulePackages = [
          config.boot.kernelPackages.kvmfr
        ];

        blacklistedKernelModules = [
          "kvmfr"
          "nvidia"
          "nvidiafb"
          "nvidia-drm"
          "nvidia-uvm"
          "nvidia-modeset"
          "nouveau"
        ];
        kernelModules = [
          "vfio_virqfd"
          "vfio_pci"
          "vfio_iommu_type1"
          "vfio"
        ];
        extraModprobeConfig = "options kvmfr static_size_mb=128 vfio-pci ids=10de:2782,10de:22bc";
      };
      services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="qemu-libvirtd", GROUP="kvm", MODE="0660"
      '';
      virtualisation.libvirtd.qemu.verbatimConfig = ''
        namespaces = []
        user = "+1000"
        cgroup_device_acl = [
          "/dev/kvmfr0",
          "/dev/vfio/vfio", "/dev/vfio/11", "/dev/vfio/12",
          "/dev/null", "/dev/full", "/dev/zero",
          "/dev/random", "/dev/urandom",
          "/dev/ptmx", "/dev/kvm"
        ]
      '';
    };
}
