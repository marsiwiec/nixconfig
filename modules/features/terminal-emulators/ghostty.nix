{
  flake.modules.homeManager.ghostty =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        systemd.enable = true;
        enableZshIntegration = true;
        installBatSyntax = true;
        settings = {
          confirm-close-surface = false;
          font-size = 14;
          font-family = pkgs.nerd-fonts.intone-mono;
          cursor-style = "bar";
          shell-integration = "detect";
          window-padding-x = 14;
          window-padding-y = 14;
        };
      };
    };
}
