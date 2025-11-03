{ lib, config, ... }:
{
  options = {
    ghostty.enable = lib.mkEnableOption "ghostty terminal config";
  };
  config = lib.mkIf config.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        window-decoration = false;
        gtk-single-instance = true;
      };
    };
  };
}
