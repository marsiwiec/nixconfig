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
    inputs.dankMaterialShell.nixosModules.greeter
  ];
  config = lib.mkIf config.dankMaterialShell.enable {
    programs = {
      dankMaterialShell.greeter = {
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
  };
}
