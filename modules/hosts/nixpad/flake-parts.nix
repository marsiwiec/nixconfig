{
  inputs,
  ...
}:
{
  # Registers the nixpad NixOS configuration.
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "nixpad";

  # Secure Boot input (lanzaboote) — nixpad only. Declared here so it lives
  # with the host that uses it; consumed by modules/hosts/nixpad/secureboot.nix.
  flake-file.inputs = {
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}