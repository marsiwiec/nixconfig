{
  config,
  lib,
  inputs,
  ...
}:
{
  perSystem = { pkgs, ... }:
  {
    devShells = {
      default = pkgs.mkShell {
        name = "nixconfig";
        shell = pkgs.zsh;
        packages = with pkgs; [
          git
          nixfmt
          sops
        ];
        shellHook = ''
          echo "nixconfig devshell — happy hacking"
        '';
      };

      python = pkgs.mkShell {
        name = "python";
        shell = pkgs.zsh;
        packages = with pkgs; [
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

      r = pkgs.mkShell {
        name = "r";
        shell = pkgs.zsh;
        packages = [
          (pkgs.rWrapper.override {
            packages = with pkgs.rPackages; [
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
    };
  };

  flake.modules.homeManager.devshells = {
    home.shellAliases = {
      devnix = "nix develop /home/msiwiec/nixconfig#default";
      devpy = "nix develop /home/msiwiec/nixconfig#python";
      devr = "nix develop /home/msiwiec/nixconfig#r";
      initnix = "nix flake init -t /home/msiwiec/nixconfig#default";
      initpy = "nix flake init -t /home/msiwiec/nixconfig#python";
      initr = "nix flake init -t /home/msiwiec/nixconfig#r";
    };

    programs.zsh = {
      initContent = ''
        nixdev() { nix develop /home/msiwiec/nixconfig#''${1:-default}; }
        nixinit() { nix flake init -t /home/msiwiec/nixconfig#''${1:-default}; }
      '';
    };

    programs.nushell = {
      extraConfig = ''
        def nixdev [shell: string = "default"] {
          nix develop $"/home/msiwiec/nixconfig#($shell)"
        }
        def nixinit [shell: string = "default"] {
          nix flake init -t $"/home/msiwiec/nixconfig#($shell)"
        }
      '';
    };
  };

  flake.templates = {
    default = {
      path = inputs.self.outPath + "/templates/default";
      description = "Basic nix devshell with git, nixfmt, and sops";
    };
    python = {
      path = inputs.self.outPath + "/templates/python";
      description = "Python devshell with uv, black, and marimo";
    };
    r = {
      path = inputs.self.outPath + "/templates/r";
      description = "R devshell with tidyverse, shiny, devtools, and more";
    };
  };
}