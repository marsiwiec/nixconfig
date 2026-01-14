{
  lib,
  config,
  pkgs,
  inputs,
  vars,
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
      sddm-theme
      sddm-theme.test
    ];
    qt.enable = true;
    services.displayManager = {
      sddm = {
        enable = true;
        package = lib.mkForce pkgs.kdePackages.sddm;
        theme = sddm-theme.pname;
        extraPackages = sddm-theme.propagatedBuildInputs;
        settings = {
          General = {
            GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
            InputMethod = "qtvirtualkeyboard";
          };
          Theme = {
            CursorTheme = "Bibata-Modern-Ice";
          };
        };
        wayland.enable = true;
      };
    };
    systemd.tmpfiles.rules =
      let
        iconPath = ../../../../style/avatars/neuron.png;
      in
      [
        "f+ /var/lib/AccountsService/users/${vars.userName}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${vars.userName}\\n"
        "L+ /var/lib/AccountsService/icons/${vars.userName}  -    -    -    -  ${iconPath}"
      ];
  };
}
