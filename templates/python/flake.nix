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
            uv
          ];
          shellHook = ''
            export PATH="$HOME/.local/bin:$PATH"
            uv python install 3.12 2>/dev/null || true
            uv tool install black 2>/dev/null || true
            uv tool install marimo 2>/dev/null || true
            echo "python devshell — uv-managed python, black, and marimo are ready"
          '';
        };
      });
    };
}
