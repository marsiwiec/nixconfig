{
  pkgs,
  ...
}:
{
  stylix = {
    enable = true;
    polarity = "dark";
    fonts = {
      monospace = {
        name = "IntoneMono NF";
        package = pkgs.nerd-fonts.intone-mono;
      };
      sansSerif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
      sizes = {
        desktop = 14;
        terminal = 16;
        popups = 14;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 36;
    };
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus";
    };
  };
}
