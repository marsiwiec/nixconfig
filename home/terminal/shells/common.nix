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
    home.packages = [ pkgs.microfetch ];
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
        enableZshIntegration = true;
        enableNushellIntegration = true;
        nix-direnv.enable = true;
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };
      atuin = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };
      yazi = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };
      zellij = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          show_startup_tips = false;
        };
      };
      carapace = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;
      };
    };
  };
}
