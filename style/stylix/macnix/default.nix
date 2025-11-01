{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../common.nix
  ];
  stylix = {
    enable = true;
    image = ../../wallpapers/great_wave.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  };
}
