{
  lib,
  config,
  pkgs,
  inputs,
  vars,
  ...
}:
{
  options.dankMaterialShell.enable = lib.mkEnableOption "enable DMS config";
  imports = [
    inputs.dms.nixosModules.greeter
  ];
  config = lib.mkIf config.dankMaterialShell.enable {
    programs = {
      dank-material-shell.greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = "/home/${vars.userName}";
        configFiles = [ "/home/${vars.userName}/.config/DankMaterialShell/settings.json" ];
        logs = {
          save = true;
          path = "/tmp/dms-greeter.log";
        };
      };

      dsearch = {
        enable = true;
        systemd.enable = true;
      };
    };
    ### Stuff below is for unlocking github and gitea ssh passkeys on login
    # as per https://discourse.nixos.org/t/gpg-ssh-gnome-keyring-recommendation/48647/8
    services.gnome.gnome-keyring.enable = true;
    security.pam.services = {
      login.enableGnomeKeyring = true;
      greetd.enableGnomeKeyring = true;
      greetd-password.enableGnomeKeyring = true;
    };
    services.dbus.packages = with pkgs; [
      gnome-keyring
      gcr
    ];
  };
}
