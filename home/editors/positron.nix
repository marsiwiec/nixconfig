{
  lib,
  config,
  pkgs,
  ...
}:
let
  positron = pkgs.positron-bin.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = pkgs.fetchurl {
        url = "https://cdn.posit.co/positron/dailies/deb/x86_64/Positron-2025.04.0-109-x64.deb";
        hash = "sha256-OZtH88Krm3x4Gw/iXXud6kx7OfwHOmD1eRitpgI+XBM=";
      };
    }
  );
in
{
  options = {
    positron.enable = lib.mkEnableOption "positron IDE";
  };
  config = lib.mkIf config.positron.enable {
    home.packages = [ positron ];
  };
}
