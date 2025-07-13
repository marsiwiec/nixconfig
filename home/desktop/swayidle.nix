{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    swayidle.enable = lib.mkEnableOption "enable swayidle config";
  };

  config = lib.mkIf config.swayidle.enable {
    services.swayidle = {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${lib.getExe pkgs.swaylock}";
        }
        {
          event = "after-resume";
          command = "${lib.getExe pkgs.niri} msg action power-on-monitors";
        }
      ];
      timeouts = [
        {
          timeout = 600;
          command = "${lib.getExe pkgs.swaylock}";
        }
        {
          timeout = 900;
          command = "${lib.getExe pkgs.niri} msg action power-off-monitors";
        }
      ];
    };
  };
}
