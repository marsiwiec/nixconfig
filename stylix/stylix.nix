{pkgs, ...}: {
  stylix = {
    enable = true;
    image = ../wallpapers/eldenring2.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
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
        desktop = 12;
      };
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
  };
}