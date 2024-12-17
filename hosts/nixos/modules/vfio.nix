let
  # GTX1060
  gpuIDs = [
    "10de:2782" # Graphics
    "10de:22bc" # Audio
  ];
in
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";
  config =
    let
      cfg = config.vfio;
    in
    {
      programs.dconf.enable = true;
      environment.systemPackages = with pkgs; [
        virt-manager
        quickemu
      ];

      programs.virt-manager.enable = true;
      virtualisation = {
        libvirtd = {
          enable = true;
          onShutdown = "shutdown";
          qemu = {
            package = pkgs.qemu_kvm;
            swtpm.enable = true;
            ovmf = {
              enable = true;
              packages = [ pkgs.OVMFFull.fd ];
            };
          };
        };
      };
      boot = {
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          # "nvidia_modeset"
          # "nvidia_uvm"
          # "nvidia_drm"
        ];

        kernelParams =
          [
            "amd_iommu=on"
          ]
          ++ lib.optional cfg.enable
            # isolate the GPU
            ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);

        blacklistedKernelModules = [
          "nouveau"
          #"nvidia"
          #"nvidia_modeset"
          #"nvidia_uvm"
          #"nvidia_drm"
        ];
      };

      hardware.graphics.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };
}
