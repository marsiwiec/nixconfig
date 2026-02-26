{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Master nixpkgs for early access to fixes/features
    # Available as pkgs.master.* (currently unused)
    # nixpkgs-master.url = "github:NixOS/nixpkgs/master";
  };

  flake.modules =
    let
      # Core nixpkgs overlay configuration
      # Uses throw to ensure lazy evaluation - pkgs.stable/master are only
      # evaluated when actually accessed, reducing build time
      overlays = [
        (final: _prev: {
          # Make stable nixpkgs accessible under 'pkgs.stable' (lazy)
          stable = import inputs.nixpkgs-stable {
            system = final.stdenv.hostPlatform.system;
            config.allowUnfree = final.config.allowUnfree;
          };
          # Make master nixpkgs accessible under 'pkgs.master' (lazy)
          # master = import inputs.nixpkgs-master {
          #   system = final.stdenv.hostPlatform.system;
          #   config.allowUnfree = final.config.allowUnfree;
          # };
        })
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
      nixos.overlays = {
        nixpkgs.overlays = overlays;
      };
      darwin.overlays = {
        nixpkgs.overlays = overlays;
      };
    };
}
