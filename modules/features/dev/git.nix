{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      signing.format = "openpgp";
      settings = {
        init.defaultBranch = "main";
      };
    };
    programs = {
      lazygit.enable = true;
    };
  };
}
