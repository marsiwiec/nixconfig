{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    mpv.enable = lib.mkEnableOption "mpv player config";
  };
  config = lib.mkIf config.mpv.enable {
    programs.mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };
  };
}
