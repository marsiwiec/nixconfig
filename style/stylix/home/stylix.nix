{ pkgs, ... }:
{
  imports = [
    ../system/stylix.nix
  ];
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus";
    };
  };
}