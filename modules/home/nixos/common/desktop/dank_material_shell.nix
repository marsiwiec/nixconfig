{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    dms.enable = lib.mkEnableOption "enable DankMaterialShell";
  };

  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  config = lib.mkIf config.dms.enable {
    programs.dankMaterialShell = {
      enable = true;
      niri = {
        # enableKeybinds = true;
        enableSpawn = true;
      };
    };
  };
}
