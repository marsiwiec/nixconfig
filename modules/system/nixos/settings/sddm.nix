{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in
{
  options = {
    sddm.enable = lib.mkEnableOption "config for sddm theme";
  };
  config = lib.mkIf config.sddm.enable {
    environment.systemPackages = [
      pkgs.bibata-cursors
      # (catppuccin-sddm.override {
      #   flavor = "frappe";
      #   font = "Intel One Mono";
      #   fontSize = "12";
      #   background = "${../../style/wallpapers/wolf.png}";
      #   loginBackground = true;
      # })
      # (sddm-astronaut.override {
      #   embeddedTheme = "pixel_sakura_static";
      # })
      sddm-theme
      sddm-theme.test
    ];
    qt.enable = true;
    services.displayManager = {
      # autoLogin = {
      #   enable = if config.networking.hostName == "nixgroot" then true else false;
      #   user = "msiwiec";
      # };
      sddm = {
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm;
        theme = sddm-theme.pname;
        extraPackages = sddm-theme.propagatedBuildInputs;
        # if config.networking.hostName == "labnix" then
        #   "catpuccin-latte"
        # else if config.networking.hostName == "nixgroot" then
        #   "sddm-astronaut-theme"
        # else
        #   [ ];
        settings = {
          General = {
            GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
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
    # Stuff below is for user avatar
    systemd.tmpfiles.rules =
      let
        user = "msiwiec";
        iconPath = ../../../../style/avatars/neuron.png;
      in
      [
        "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
        "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
      ];
  };
}
