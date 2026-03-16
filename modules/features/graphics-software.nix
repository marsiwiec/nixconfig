{ lib, ... }:
{
  flake.modules.homeManager.graphics-software =
    { osConfig, pkgs, ... }:
    let
      fiji = rec {
        appId = "sc.fiji.fiji";
        sha256 = "sha256-R6AYQ7Cuvy1X0T6Mf8zCOM8aAerF4rei2EvIOKSnZGg=";
        bundle = "${pkgs.fetchurl {
          url = "https://github.com/ximion/fiji-builds/releases/download/x-test/Fiji.flatpak";
          inherit sha256;
        }}";
      };
    in
    {
      services.flatpak.packages = lib.mkIf osConfig.services.flatpak.enable [
        "org.gimp.GIMP"
        "org.inkscape.Inkscape"
        "org.kde.krita"
        "com.github.PintaProject.Pinta"
        "org.blender.Blender"
        fiji
      ];

      services.flatpak.overrides = {
        "sc.fiji.fiji" = {
          Environment = {
            _JAVA_AWT_WM_NONREPARENTING = "1"; # Fix for nonresponsive app menu
          };
        };
      };

      home.packages = with pkgs; [
        # inkscape-with-extensions
        # gimp3-with-plugins
        # krita
        # fiji
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
