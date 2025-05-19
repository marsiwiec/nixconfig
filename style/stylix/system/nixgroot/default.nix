{ pkgs, ... }:
{
  stylix = {
    image = ../../../wallpapers/clair_obscur.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  };
}
