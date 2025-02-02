{
  lib,
  config,
  ...
}:
{
  options = {
    hypridle.enable = lib.mkEnableOption "enable hypridle config for hyprland and other WMs";
  };

  config = lib.mkIf config.hypridle.enable {
    systemd.user.services = {
      hypridle.Unit.After = lib.mkForce "graphical-session.target";
      hyprpaper.Unit.After = lib.mkForce "graphical-session.target";
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "uwsm app -- pidof hyprlock || uwsm app -- hyprlock"; # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "uwsm app -- loginctl lock-session"; # lock before suspend.
          after_sleep_cmd = "uwsm app -- hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

        listener = [
          {
            timeout = 600; # 5min
            on-timeout = "uwsm app -- loginctl lock-session"; # lock screen when timeout has passed
          }
          {
            timeout = 1800;
            on-timeout = "uwsm app -- hyprctl dispatch dpms off"; # screen off when timeout has passed
            on-resume = "uwsm app -- hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
          }
        ];
      };
    };
  };
}
