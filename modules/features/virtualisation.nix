{
  flake.modules.nixos.virtualisation =
    {
      config,
      pkgs,
      ...
    }:
    {
      virtualisation = {
        libvirtd = {
          enable = true;
          onBoot = "ignore";
          qemu = {
            swtpm.enable = true;
            vhostUserPackages = [ pkgs.virtiofsd ];
          };
        };

        spiceUSBRedirection.enable = true;
      };

      users.users.${config.systemConstants.username}.extraGroups = [ "libvirtd" ];

      environment.systemPackages = with pkgs; [
        spice
        spice-gtk
        spice-protocol
        freerdp
      ];
      programs.virt-manager.enable = true;
    };
}
