{
  flake.modules.nixos.logitech =
    { pkgs, ... }:
    {
      services.ratbagd = {
        enable = true;
        package = pkgs.libratbag.overrideAttrs (old: {
          version = "0-unstable-2026-08-18";
          src = pkgs.fetchFromGitHub {
            owner = "libratbag";
            repo = "libratbag";
            rev = "b8d4d3ca1f4d6b23c664ffee2888b8eb669bee21";
            sha256 = "sha256-8V/LIki/tI/9Wi6kuFJp6k1p+moMh8Gc8RNP1BUlZO8=";
          };
        });
      };
      services.flatpak.packages = [
        "org.freedesktop.Piper"
      ];
    };
}
