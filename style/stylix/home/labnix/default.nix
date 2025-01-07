{ pkgs, ... }:
{
  stylix = {
    image = ../../../wallpapers/wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
