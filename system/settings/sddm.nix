{
  lib,
  config,
  pkgs,
  inputs,
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
      inputs.silent-sddm.packages.x86_64-linux.sddm-silent
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
          inputs.silent-sddm.packages.x86_64-linux.sddm-silent
        ];
        theme = "silent";
        # if config.networking.hostName == "labnix" then
        #   "catpuccin-latte"
        # else if config.networking.hostName == "nixgroot" then
        #   "sddm-astronaut-theme"
        # else
        #   [ ];
        settings = {
          General = {
            GreeterEnvironment = "QML2_IMPORT_PATH=/run/current-system/sw/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard";
            InputMethod = "qtvirtualkeyboard";
          };
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
