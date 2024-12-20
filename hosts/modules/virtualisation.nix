{
  config,
  lib,
  pkgs,
  username,
  ...
}:

with lib;
let
  cfg = config.virtualisation.kvmfr;
in
{
  options.virtualisation.kvmfr = {
    enable = mkEnableOption "kvmfr";

    shm = {
      enable = mkEnableOption "shm";

      size = mkOption {
        type = types.int;
        default = "128";
        description = "Size of the shared memory device in megabytes.";
      };
      user = mkOption {
        type = types.str;
        default = "root";
        description = "Owner of the shared memory device.";
      };
      group = mkOption {
        type = types.str;
        default = "root";
        description = "Group of the shared memory device.";
      };
      mode = mkOption {
        type = types.str;
        default = "0600";
        description = "Mode of the shared memory device.";
      };
    };
  };

  config = {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
      libvirtd = {
        enable = true;
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

    services.udev.extraRules = optionals cfg.shm.enable ''
      SUBSYSTEM=="kvmfr", OWNER="${cfg.shm.user}", GROUP="${cfg.shm.group}", MODE="${cfg.shm.mode}"
    '';

    users.users.${username}.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      distrobox
      spice
      spice-gtk
      spice-protocol
      freerdp
    ];
    programs.virt-manager.enable = true;
  };
}
