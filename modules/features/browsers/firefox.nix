{
  flake.modules.homeManager.firefox = {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          path = "default";
          settings = {
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.loadInBackground" = true;
            "media.ffmpeg.vaapi.enabled" = true;
            "extensions.autoDisableScopes" = 0;
            "browser.ml.chat.enabled" = false;
            "browser.tabs.groups.smart.enabled" = false;
          };
        };
      };
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableFirefoxScreenshots = true;
        HardwareAcceleration = true;
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };
    stylix.targets.firefox = {
      firefoxGnomeTheme.enable = true;
      profileNames = [ "default" ];
    };
    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/chrome" = [ "firefox.desktop" ];
          "text/html" = [ "firefox.desktop" ];
          "application/x-extension-htm" = [ "firefox.desktop" ];
          "application/x-extension-html" = [ "firefox.desktop" ];
          "application/x-extension-shtml" = [ "firefox.desktop" ];
          "application/xhtml+xml" = [ "firefox.desktop" ];
          "application/x-extension-xhtml" = [ "firefox.desktop" ];
          "application/x-extension-xht" = [ "firefox.desktop" ];
        };
      };
    };
  };
}
