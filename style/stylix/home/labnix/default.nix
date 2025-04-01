{ pkgs, ... }:
{
  stylix = {
    image = pkgs.fetchurl {
      url = "https://github.com/marsiwiec/nixconfig/blob/main/style/wallpapers/cheshire_cat.png?raw=true";
      sha256 = "sha256-XQkYxhbnNGs98f/4rm1yGSF0Nse5koZ7bm94cfwF890=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  };
}
