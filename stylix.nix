{ pkgs, ... }: 
{
  stylix = {
    enable = true;
    image = ./wallpaper.png;
    polarity = "dark";
    fonts = {
      monospace = {
        name = "Intel One Mono";
	package = pkgs.intel-one-mono;
      };
    };

  };
}
