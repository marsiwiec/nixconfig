{ pkgs, ... }:
{
  stylix = {
    image = pkgs.fetchurl {
      url = "https://github.com/marsiwiec/nixconfig/blob/main/style/wallpapers/wallpaper.png?raw=true";
      sha256 = "sha256-xm9MgisDK+3dwsL3SpFHP9D6Z3GWCyhNNKjm5KYTx9k=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
