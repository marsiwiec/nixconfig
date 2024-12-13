{ ... }:
{
  programs.plasma = {
    enable = true;
    krunner = {
      position = "center";
    };
    kscreenlocker = {
      appearance = {
        wallpaper = ../../wallpapers/wolf.png;
        showMediaControls = true;
      };
      lockOnResume = false;
    };
    kwin = {
      virtualDesktops = {
        number = 4;
        rows = 1;
      };
    };
  };
}
