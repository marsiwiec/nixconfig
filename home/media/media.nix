{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    media.enable = lib.mkEnableOption "config for basic image/video viewers";
  };
  config = lib.mkIf config.media.enable {
    programs.mpv = {
      enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = [ pkgs.mpvScripts.mpris ];
    };
    programs.imv.enable = true;
  };
}
