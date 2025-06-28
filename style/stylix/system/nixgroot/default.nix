{ pkgs, ... }:
{
  stylix = {
    image = ../../../wallpapers/flowers.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  };
}
