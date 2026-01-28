{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    firefox.enable = lib.mkEnableOption "enable firefox";
  };
  config = lib.mkIf config.firefox.enable {
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
  };
}
