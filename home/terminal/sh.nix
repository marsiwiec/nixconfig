{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    sh.enable = lib.mkEnableOption "shell config, aliases etc.";
  };

  config = lib.mkIf config.sh.enable {

    home.packages = [ pkgs.microfetch ];

    home.shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "/" = "cd /";
      sudo = "sudo ";
      v = "nvim";
      yy = "yazi";
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      lg = "lazygit";
      nixdiff = "nix run nixpkgs#nvd -- diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
    };
    programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
          KITTY_INSTANCES=0
          for pid in $(pidof -x kitty); do
            KITTY_INSTANCES=$((KITTY_INSTANCES+1))
          done
          if [[ KITTY_INSTANCES -eq 1 ]]; then
            date
            microfetch
          fi
        '';
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
      atuin = {
        enable = true;
      };
      zoxide = {
        enable = true;
      };
    };
  };
}
