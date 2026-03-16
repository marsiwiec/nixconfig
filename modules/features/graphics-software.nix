{ lib, ... }:
{
  flake.modules.homeManager.graphics-software =
    { osConfig, pkgs, ... }:
    {
      services.flatpak.packages = lib.mkIf osConfig.services.flatpak.enable [
        "org.gimp.GIMP"
        "org.inkscape.Inkscape"
        "org.kde.krita"
        "com.github.PintaProject.Pinta"
        "org.blender.Blender"
      ];
      home.packages = with pkgs; [
        # inkscape-with-extensions
        # gimp3-with-plugins
        # krita
        fiji
        # pinta
        # (blender.override {
        #   cudaSupport = true;
        # })
      ];
      xdg = {
        enable = true;
        mimeApps = {
          enable = true;
          defaultApplications = {
            "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
            "image/gif" = [ "imv.desktop" ];
          };
        };
      };
    };
}
