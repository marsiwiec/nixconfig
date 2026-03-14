{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      systemd.enable = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      settings = {
        confirm-close-surface = false;
        font-size = 14;
        cursor-style = "bar";
        shell-integration = "detect";
      };
    };
  };
}
