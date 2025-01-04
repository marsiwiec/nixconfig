{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    sddm.enable = lib.mkEnableOption "config for sddm and catppuccin theme";
  };
  config = lib.mkIf config.sddm.enable {
    environment.systemPackages = with pkgs; [

      bibata-cursors

      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          passwordCharacter = " ";
          passwordInputWidth = "0.15";
          passwordInputBackground = "#99${config.lib.stylix.colors.base01}";
          passwordInputCursorVisible = false;
          background = "${../../style/wallpapers/eldenring2.jpg}";
          font = "Intel One Mono";
          basicTextColor = "#${config.lib.stylix.colors.base05}";
          passwordFontSize = "20";
          showSessionsByDefault = true;
          sessionsFontSize = "24";
          showUsersByDefault = true;
          usersFontSize = "28";
        };
      })
    ];
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "where_is_my_sddm_theme";
      extraPackages = with pkgs; [
        qt6.qt5compat
      ];
      settings = {
        Theme = {
          CursorTheme = "Bibata-Modern-Ice";
        };
      };
      wayland = {
        enable = true;
      };
    };
  };
}
