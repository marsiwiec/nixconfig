{ lib, config, ... }:
{
  options = {
    zathura.enable = lib.mkEnableOption "zathura pdf reader";
  };
  config = lib.mkIf config.zathura.enable {
    programs.zathura.enable = true;
  };
}