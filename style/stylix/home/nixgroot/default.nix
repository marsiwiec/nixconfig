{ pkgs, ... }:
{
  stylix = {
    image = pkgs.fetchurl {
      url = "https://github.com/marsiwiec/nixconfig/blob/main/style/wallpapers/eldenring2.jpg?raw=true";
      sha256 = "sha256-gYrj3flVdq/icENLt9+RrFQtwOJPyBv8ToXLD+PN4yU=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
  };
}
