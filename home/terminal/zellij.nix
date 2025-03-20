{
  lib,
  config,
  ...
}:
{
  options = {
    zellij.enable = lib.mkEnableOption "zellij config";
  };
  config = lib.mkIf config.zellij.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        show_startup_tips = false;
        # ui = {
        #   pane_frames = {
        #     rounded_corners = true;
        #   };
        # };
      };
    };
  };
}
