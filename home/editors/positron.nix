{
  lib,
  config,
  pkgs,
  ...
}:
let
  positron = pkgs.positron-bin.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2025.07.0-204";
      src = pkgs.fetchurl {
        url = "https://cdn.posit.co/positron/releases/deb/x86_64/Positron-2025.07.0-204-x64.deb";
        hash = "sha256-f27LC4+SXnkyePw/fw8r9JYsOQKVoIiFkAet/QtwbNg=";
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
