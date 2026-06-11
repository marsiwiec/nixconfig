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
          packages = [
            (nixpkgs.legacyPackages.${system}.rWrapper.override {
              packages = with nixpkgs.legacyPackages.${system}.rPackages; [
                tidyverse
                shiny
                rmarkdown
                knitr
                jsonlite
                rvest
                httr
                RSQLite
                DBI
                devtools
                renv
                rlang
                fs
                testthat
                pkgload
                glue
                magrittr
                tibble
              ];
            })
          ];
          shellHook = ''
            echo "R devshell — tidyverse, shiny, devtools, etc. are ready"
          '';
        };
      });
    };
}
