{
  flake.modules.nixos.virtualisation =
    {
      config,
      pkgs,
      ...
    }:
    let
      username = config.systemConstants.username;
    in
    {
      virtualisation = {
        libvirtd = {
          enable = true;
          onBoot = "ignore";
          qemu = {
            swtpm.enable = true;
            vhostUserPackages = [ pkgs.virtiofsd ];
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
      };

      boot = {
        extraModulePackages = [
          config.boot.kernelPackages.kvmfr
        ];
        kernelModules = [ "kvmfr" ];
        extraModprobeConfig = ''
          options kvmfr static_size_mb=128
        '';
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="qemu-libvirtd", GROUP="kvm", MODE="0660"
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
