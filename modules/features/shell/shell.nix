{
  flake.modules.nixos.shell = {
    programs.zsh.enable = true;
  };
  flake.modules.homeManager.shell =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        unzip
        duf
        just
      ];
      home.shell.enableNushellIntegration = true;
      home.shell.enableZshIntegration = true;
      home.shellAliases = {
        ll = "ls -l";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "/" = "cd /";
        sudo = "sudo ";
        v = "nvim";
        h = "hx";
        yy = "yazi";
        lg = "lazygit";
      };

      programs = {
        command-not-found.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        starship.enable = true;
        atuin.enable = true;
        zoxide.enable = true;
        yazi.enable = true;
        htop.enable = true;
        bat.enable = true;
        gnupg.agent.enable = true;
        zellij = {
          enable = true;
          enableZshIntegration = true; # Still needs it
          settings = {
            show_startup_tips = false;
          };
        };
        zsh = {
          enable = true;
          dotDir = "${config.xdg.configHome}/zsh";
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          shellAliases = {
            ls = "ls --color=auto";
            grep = "grep --color=auto";
            nixdiff = "nix run nixpkgs#nvd -- diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
          };
          defaultKeymap = "emacs";
          initContent = lib.mkIf pkgs.stdenv.isLinux ''
            if [[ $(wezterm cli list | wc -l) -eq 2 ]]; then
              date
              ${lib.getExe pkgs.microfetch}
            fi
          '';
        };
        nushell = {
          enable = true;
          settings = {
            buffer_editor = "hx";
            show_banner = false;
          };
          extraConfig = ''
            def start_zellij [] {
              if 'ZELLIJ' not-in ($env | columns) {
                if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
                  zellij attach -c
                } else {
                  zellij
                }

                if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
                  exit
                }
              }
            }
            start_zellij
            ${lib.getExe pkgs.cowsay} nu
          '';
        };
      };
    };
}
