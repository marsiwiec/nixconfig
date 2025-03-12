{ pkgs, ... }:
{
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus";
    };
    targets = {
      waybar = {
        font = "sansSerif";
      };
    };
  };
}
