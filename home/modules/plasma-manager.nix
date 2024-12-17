{ ... }:
{
  programs.plasma = {
    enable = true;
    configFile.kdeglobals.General = {
      BrowserApplication = "firefox.desktop";
      TerminalApplication = "kitty";
    };
    powerdevil = {
      AC.powerProfile = "performance";
    };
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
    shortcuts = {
      kwin = {
        "Window Close" = [ "Meta+Q" ];
      };
    };
  };
}
