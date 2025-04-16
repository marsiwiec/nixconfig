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
        url = "https://cdn.posit.co/positron/dailies/deb/x86_64/Positron-2025.05.0-58-x64.deb";
        hash = "sha256-xJ+B4AwSj/2pQKrGtidbNSiLORlhMI6gDR9XMw8eDLU=";
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
