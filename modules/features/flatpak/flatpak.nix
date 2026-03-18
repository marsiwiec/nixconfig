{ inputs, ... }:
{
  flake.modules.nixos.flatpak = {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    home-manager.sharedModules = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      packages = [
        "io.github.kolunmi.Bazaar"
        "com.github.tchx84.Flatseal"
      ];
    };
  };
}
