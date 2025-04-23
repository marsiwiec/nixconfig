{
  lib,
  config,
  pkgs,
  ...
}:
let
  positron = pkgs.positron-bin.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2025.05.0-075";
      src = pkgs.fetchurl {
        url = "https://cdn.posit.co/positron/dailies/deb/x86_64/Positron-2025.05.0-75-x64.deb";
        hash = "sha256-dmJrDE3g44aoCsVBvSDDFLt38uIqxzaXPBhcmu/U5Oo=";
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
