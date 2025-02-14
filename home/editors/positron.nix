{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    positron.enable = lib.mkEnableOption "positron IDE";
  };
  config = lib.mkIf config.positron.enable {
    home.packages = with pkgs; [
      (positron-bin.overrideAttrs (attrs: {
        src = fetchurl {
          url = "https://github.com/posit-dev/positron/releases/download/2025.02.0-137/Positron-2025.02.0-137-x64.deb";
          hash = "sha256-Q4dDx4c3nNjoZPtoIkVAlisGShqtz4pIKXVh+5fngaI=";
        };
        installPhase = ''
          runHook preInstall
          mkdir -p "$out/share"
          cp -r usr/share/pixmaps "$out/share/pixmaps"
          cp -r usr/share/positron "$out/share/positron"

          mkdir -p "$out/share/applications"
          install -m 444 -D usr/share/applications/positron.desktop "$out/share/applications/positron.desktop"
          substituteInPlace "$out/share/applications/positron.desktop" \
            --replace-fail \
            "Icon=co.posit.positron" \
            "Icon=$out/share/pixmaps/co.posit.positron.png" \
            --replace-fail \
            "Exec=/usr/share/positron/positron %F" \
            "Exec=$out/share/positron/.positron-wrapped %F" \
            --replace-fail \
            "/usr/share/positron/positron --new-window %F" \
            "$out/share/positron/.positron-wrapped --new-window %F"

          # Fix libGL.so not found errors.
          wrapProgram "$out/share/positron/positron" \
            --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ libglvnd ]}"

          mkdir -p "$out/bin"
          ln -s "$out/share/positron/positron" "$out/bin/positron"
          runHook postInstall
        '';
      }))
    ];
  };
}
