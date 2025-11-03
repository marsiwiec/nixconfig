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
      extraArgs = [
        "-w"
      ];
      events = [
        {
          event = "before-sleep";
          command = "${lib.getExe pkgs.swaylock} -f";
        }
        {
          event = "lock";
          command = "${lib.getExe pkgs.swaylock} -f";
        }
        {
          event = "after-resume";
          command = "${lib.getExe pkgs.niri} msg action power-on-monitors";
        }
      ];
      timeouts = [
        {
          timeout = 900;
          command = "${lib.getExe pkgs.swaylock} -f";
        }
        {
          timeout = 1200;
          command = "${lib.getExe pkgs.niri} msg action power-off-monitors";
        }
      ];
    };
  };
}
