{
  lib,
  config,
  ...
}:
{
  options = {
    sh.enable = lib.mkEnableOption "shell config, aliases etc.";
  };

  config = lib.mkIf config.sh.enable {
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
