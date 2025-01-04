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
      (catppuccin-sddm.override {
        flavor = "frappe";
        font = "Intel One Mono";
        fontSize = "12";
        background = "${../../style/wallpapers/eldenring.jpg}";
        loginBackground = true;
      })
    ];
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-frappe";
      wayland = {
        enable = true;
      };
    };
  };
}
