{
  lib,
  config,
  ...
}:
{
  options = {
    git.enable = lib.mkEnableOption "enable git config with gh-cli etc";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
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
