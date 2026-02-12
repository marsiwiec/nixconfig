{ config, lib, ... }:
{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = lib.mkDefault {
          name = "marsiwiec";
          email = "marsiwiec@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };
    };
    programs = {
      lazygit.enable = true;
    };
  };
}
