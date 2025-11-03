{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    shell-common.enable = lib.mkEnableOption "common shell config, aliases etc.";
  };

  config = lib.mkIf config.shell-common.enable {
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
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      starship.enable = true;
      atuin.enable = true;
      zoxide.enable = true;
      yazi.enable = true;
      zellij = {
        enable = true;
        enableZshIntegration = true; # Still needs it
        settings = {
          show_startup_tips = false;
        };
      };
    };
  };
}
