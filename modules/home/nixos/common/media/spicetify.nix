{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  options = {
    spicetify.enable = lib.mkEnableOption "enable spicetify customization of spotify";
  };
  config = lib.mkIf config.spicetify.enable {
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
      ];
    };
  };
}
