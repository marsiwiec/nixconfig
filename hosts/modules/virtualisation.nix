{ pkgs, username, ... }:
{
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
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.${username}.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    distrobox
    spice
    spice-gtk
    spice-protocol
  ];
  programs.virt-manager.enable = true;
}
