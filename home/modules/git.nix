{ ... }:
{
  programs.git = {
    enable = true;
    userName = "marsiwiec";
    userEmail = "marsiwiec@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}