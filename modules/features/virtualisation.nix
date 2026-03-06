{
  inputs,
  ...
}:
{
  flake.modules.nixos.virtualisation =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      # Part 1: Overlay libvirt from the PR
      nixpkgs.overlays = [
        (final: prev: {
          libvirt = inputs.nixpkgs-pr-496839.legacyPackages.${final.system}.libvirt;
        })
      ];

      # Part 2: Use the libvirtd module from the PR
      disabledModules = [ "virtualisation/libvirtd.nix" ];
      imports = [ "${inputs.nixpkgs-pr-496839}/nixos/modules/virtualisation/libvirtd.nix" ];

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
        dnsmasq
        spice
        spice-gtk
        spice-protocol
        freerdp
      ];
      programs.virt-manager.enable = true;

      networking.firewall.trustedInterfaces = [ "virbr0" ];
    };
}
