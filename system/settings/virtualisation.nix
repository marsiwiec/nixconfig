{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  cfg = config.virtualisation.kvmfr;
in
{
  options = {
    virtualization.enable = lib.mkEnableOption "config for virtualization";
    virtualisation.kvmfr = {
      enable = lib.mkEnableOption "kvmfr";
      shm = {
        enable = lib.mkEnableOption "shm";

        size = lib.mkOption {
          type = lib.types.int;
          default = "128";
          description = "Size of the shared memory device in megabytes.";
        };
        user = lib.mkOption {
          type = lib.types.str;
          default = "root";
          description = "Owner of the shared memory device.";
        };
        group = lib.mkOption {
          type = lib.types.str;
          default = "root";
          description = "Group of the shared memory device.";
        };
        mode = lib.mkOption {
          type = lib.types.str;
          default = "0600";
          description = "Mode of the shared memory device.";
        };
      };
    };
  };

  config = lib.mkIf config.virtualization.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        onBoot = "ignore";
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
          verbatimConfig = ''
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
      };

      spiceUSBRedirection.enable = true;
      kvmfr = {
        enable = true;
        shm = {
          enable = true;
          size = 128;
          user = "msiwiec";
          group = "kvm";
          mode = "0660";
        };
      };
    };

    boot.extraModulePackages = with config.boot.kernelPackages; [
      kvmfr
    ];
    boot.kernelModules = [ "kvmfr" ];
    boot.extraModprobeConfig = ''
      options kvmfr static_size_mb=128
    '';

    services.udev.extraRules = lib.optionals cfg.shm.enable ''
      SUBSYSTEM=="kvmfr", OWNER="${cfg.shm.user}", GROUP="${cfg.shm.group}", MODE="${cfg.shm.mode}"
    '';

    users.users.${username}.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      spice-protocol
      freerdp
    ];
    programs.virt-manager.enable = true;
  };
}
