{
  flake.modules.homeManager.image-editors =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        inkscape-with-extensions
        gimp3-with-plugins
        krita
        fiji
        pinta
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
