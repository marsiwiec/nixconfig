{ pkgs, ... }:
{
  stylix = {
    image = ../../wallpapers/star_wars.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  };
}
