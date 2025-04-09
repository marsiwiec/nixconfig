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
        url = "https://cdn.posit.co/positron/dailies/deb/x86_64/Positron-2025.04.0-250-x64.deb";
        hash = "sha256-mogKmlUrE2pfq6P2F+8V6kQ9jlyd86yR+92NfKQ9xpo=";
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
