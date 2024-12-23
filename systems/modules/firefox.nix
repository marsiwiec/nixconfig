{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
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
      Preferences = {
        "browser.aboutConfig.showWarning" = false;
        "browser.tabs.loadInBackground" = true; # Load tabs automatically
        "media.ffmpeg.vaapi.enabled" = true;
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
