{
  flake.modules =
    let
      overlays = [
        # Bambu Studio fix for login fail https://github.com/NixOS/nixpkgs/issues/440951
        (final: _prev: {
          bambu-studio = _prev.appimageTools.wrapType2 rec {
            name = "BambuStudio";
            pname = "bambu-studio";
            version = "02.05.00.67";
            ubuntu_version = "24.04_PR-9540";

            src = _prev.fetchurl {
              url = "https://github.com/bambulab/BambuStudio/releases/download/v${version}/Bambu_Studio_ubuntu-${ubuntu_version}.AppImage";
              sha256 = "sha256:dee6d96e5aec389cf3d69df84228b089a80a681ee723cc4379a74558706459f8";
            };

            profile = ''
              export SSL_CERT_FILE="${_prev.cacert}/etc/ssl/certs/ca-bundle.crt"
              export GIO_MODULE_DIR="${_prev.glib-networking}/lib/gio/modules/"
            '';

            extraPkgs =
              pkgs: with pkgs; [
                cacert
                glib
                glib-networking
                gst_all_1.gst-plugins-bad
                gst_all_1.gst-plugins-base
                gst_all_1.gst-plugins-good
                webkitgtk_4_1
              ];
          };
        })
      ];
    in
    {
      homeManager.print3d =
        { osConfig, pkgs, ... }:

        {
          home.packages = with pkgs; [
            bambu-studio
            orca-slicer
            # Add desktop entry for bambu-studio (overlay did not produce one)
            (makeDesktopItem {
              name = "bambu-studio";
              desktopName = "Bambu Studio";
              exec = "bambu-studio";
              terminal = false;
              type = "Application";
              icon = "${osConfig.systemConstants.iconDir}/BambuStudio_192px.png";
            })
          ];
        };
      nixos.overlays = {
        nixpkgs.overlays = overlays;
      };
      darwin.overlays = {
        nixpkgs.overlays = overlays;
      };
    };
}
