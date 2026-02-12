{
  flake.modules.homeManager.media =
    { pkgs, ... }:
    {
      programs = {
        mpv = {
          enable = true;
          defaultProfiles = [ "gpu-hq" ];
          scripts = [ pkgs.mpvScripts.mpris ];
        };
        imv.enable = true;
      };
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "image/png" = [ "imv-dir.desktop" ];
          "image/jpeg" = [ "imv-dir.desktop" ];
        };
      };
    };
}
