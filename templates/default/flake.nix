{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    in
    {
      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          shell = nixpkgs.legacyPackages.${system}.zsh;
          packages = with nixpkgs.legacyPackages.${system}; [
            git
            nixfmt
            sops
          ];
          shellHook = ''
            echo "nixconfig devshell — happy hacking"
          '';
        };
      });
    };
}
