{ lib, pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    opacity = {
      terminal = 0.9;
    };
    fonts = {
      monospace = {
        name = "Intel One Mono";
        package = pkgs.intel-one-mono;
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
  };
}
