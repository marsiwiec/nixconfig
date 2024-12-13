let
  # GTX1060
  gpuIDs = [
    "10de:1c02" # Graphics
    "10de:10f1" # Audio
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
      programs.virt-manager.enable = true;
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
            ovmf = {
              enable = true;
              packages = [ pkgs.OVMF.fd ];
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

        blacklistedKernelModules = [ "nouveau" ];
      };

      environment = {
        systemPackages = [
          (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
            qemu-system-x86_64 \
              -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
              "$@"
          '')
        ];

      };

      hardware.graphics.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };
}
