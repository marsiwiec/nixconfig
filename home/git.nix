{
  lib,
  config,
  ...
}: {
  options = {
    git.enable = lib.mkEnableOption "enable git config with gh-cli etc";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "marsiwiec";
      userEmail = "marsiwiec@users.noreply.github.com";
      extraConfig = {
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
