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
      };
      dsearch = {
        enable = true;
        systemd.enable = true;
      };
    };
  };
}
