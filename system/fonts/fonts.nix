{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    sysfonts.enable = lib.mkEnableOption "fonts";
  };

  config = lib.mkIf config.sysfonts.enable {
    fonts.packages = with pkgs; [ corefonts ];
  };
}
