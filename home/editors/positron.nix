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
    nixpkgs.overlays = [
      (final: prev: {
        positron-bin = prev.positron-bin.overrideAttrs (old: {
          src = builtins.fetchGit {
            url = "https://github.com/NixOS/nixpkgs";
            ref = "pull/373551/head";
            rev = "5a3a76a43d9827acf2d9bd19b2cbe44a9750cdaf";
          };
        });
      })
    ];
    home.packages = with pkgs; [
      positron-bin
    ];
  };
}
