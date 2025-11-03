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
        credential = {
          "https://github.com" = {
            helper = "!gh auth git-credential";
          };
          "https://gist.github.com" = {
            helper = "!gh auth git-credential";
          };
        };
      };
    };
    programs = {
      gh = {
        enable = true;
        gitCredentialHelper.enable = false;
      };
      lazygit.enable = true;
    };
  };
}
