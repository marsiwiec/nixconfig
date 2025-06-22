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
      (sddm-astronaut.override {
        embeddedTheme = "pixel_sakura_static";
      })
    ];
    services.displayManager = {
      # autoLogin = {
      #   enable = if config.networking.hostName == "nixgroot" then true else false;
      #   user = "msiwiec";
      # };
      sddm = {
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm;
        extraPackages = with pkgs; [
          kdePackages.qtsvg
          kdePackages.qtmultimedia
          kdePackages.qtvirtualkeyboard
        ];
        theme =
          if config.networking.hostName == "labnix" then
            "catppuccin-frappe"
          else if config.networking.hostName == "nixgroot" then
            "sddm-astronaut-theme"
          else
            [ ];
        settings = {
          Theme = {
            CursorTheme = "Bibata-Modern-Ice";
          };
        };
        wayland = {
          enable = true;
          # compositor = "kwin";
        };
      };
    };
  };
}
