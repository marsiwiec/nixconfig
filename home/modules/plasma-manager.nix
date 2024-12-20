{ lib, ... }:
{
  programs.plasma = {
    enable = true;
    overrideConfig = true;
    panels = [
      {
        location = "bottom";
        height = 44;
      }
    ];
    powerdevil = {
      AC.powerProfile = "performance";
      AC.autoSuspend.action = "nothing";
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
    configFile = {
      kwinrc = {
        Windows = {
          FocusPolicy = "FocusFollowsMouse";
          DelayFocusInterval = 200;
        };
        Plugins = {
          krohnkiteEnabled = true;
        };
        Script-krohnkite = {
          enableQuartetLayout = true;
        };
      };
      ksmserverrc = {
        General.loginMode = "emptySession";
      };
      kdeglobals = {
        General = {
          BrowserApplication = "firefox.desktop";
          TerminalApplication = "kitty";
          TerminalService = "kitty.desktop";
        };
        WM = {
          frame = "61,174,233";
          inactiveFrame = "239,240,241";
        };
      };
    };
    shortcuts = {
      kwin = {
        "Window Close" = [ "Meta+Q" ];
        "Window Fullscreen" = [ "Meta+Ctrl+F" ];
      };
      "services/net.local.kitty.desktop"."_launch" = "Meta+Return";
      "services/firefox.desktop"."_launch" = "Meta+Shift+Return";
    };
  };
}
