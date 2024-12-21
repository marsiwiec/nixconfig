{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ../wallpapers/eldenring.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    fonts = {
      monospace = {
        name = "Intel One Mono";
        package = pkgs.intel-one-mono;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };
}
