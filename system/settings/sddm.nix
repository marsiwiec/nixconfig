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
      (catppuccin-sddm.override {
        flavor = "frappe";
        font = "Intel One Mono";
        fontSize = "12";
        background = "${../../style/wallpapers/wolf.png}";
        loginBackground = true;
      })
    ];
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-frappe";
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
