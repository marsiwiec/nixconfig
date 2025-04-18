{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    devenv.enable = lib.mkEnableOption "enable devenv environments";
  };

  config = lib.mkIf config.devenv.enable {
    environment.systemPackages = with pkgs; [
      devenv
    ];
    nix.extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
      extra-trusted-public-keys = nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=
    '';
  };
}
