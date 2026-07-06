{ inputs, ... }:
{
  flake.modules.nixos.flatpak = { pkgs, ... }: {
    imports = [
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];

    home-manager.sharedModules = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];

    services.flatpak = {
      enable = true;
      # Pin to 1.16.6 to work around a regression in 1.18.0 where flatpak-spawn
      # leaks the host PATH into subsandboxes, breaking glycin image/SVG loaders
      # in Inkscape, GIMP and other GTK apps on NixOS.
      # See: https://github.com/flatpak/flatpak/issues/6717
      # See: https://github.com/NixOS/nixpkgs/issues/535787
      package = pkgs.flatpak.overrideAttrs (oldAttrs: rec {
        version = "1.16.6";
        src = pkgs.fetchurl {
          url = "https://github.com/flatpak/flatpak/releases/download/${version}/flatpak-${version}.tar.xz";
          hash = "sha256-HmPn8/5EtgLzTZKm/kb9ijvGvpRgwDwmgeV5dsZY7sM=";
        };
      });
      packages = [
        "io.github.kolunmi.Bazaar"
        "com.github.tchx84.Flatseal"
      ];
    };
  };
}
