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
        default_mode = "locked";
        ui = {
          pane_frames = {
            rounded_corners = true;
          };
        };
      };
    };
  };
}
