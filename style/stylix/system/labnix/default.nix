{ pkgs, ... }:
{
  stylix = {
    image = ../../../wallpapers/wolf.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  };
}
