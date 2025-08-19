{ pkgs, ... }:
{
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    image = ../../../wallpapers/star_wars.png;
  };
}
