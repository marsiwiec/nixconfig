{
  flake.modules.generic.stylix =
    { pkgs, ... }:
    {
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
    };
  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      stylix = {
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
    };
  flake.modules.homeManager.stylix =
    { osConfig, ... }:
    {
      stylix = {
        icons = osConfig.stylix.icons;
        targets = {
          waybar = {
            font = "sansSerif";
          };
          firefox = {
            firefoxGnomeTheme.enable = true;
            profileNames = [ "default" ];
          };
        };
      };
    };
}
