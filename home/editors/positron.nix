{
  lib,
  config,
  pkgs,
  ...
}:
let
  positron = pkgs.positron-bin.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2025.06.0-146";
      src = pkgs.fetchurl {
        url = "https://cdn.posit.co/positron/dailies/deb/x86_64/Positron-2025.06.0-146-x64.deb";
        hash = "sha256-FnNoLV9uqgUeumYpHtRJuHrFA6mL65KI4jru7Ebq0/o=";
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
