{ config, lib, ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = lib.mkDefault {
          name = "${config.systemConstants.username}";
          email = "${config.systemConstants.username}@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };
    };
    programs = {
      lazygit.enable = true;
    };
  };
}
