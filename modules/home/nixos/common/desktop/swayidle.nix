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
      events = {
        "before-sleep" = "${lib.getExe pkgs.swaylock} -f";
        "lock" = "${lib.getExe pkgs.swaylock} -f";
        "after-resume" = "${lib.getExe pkgs.niri} msg action power-on-monitors";
      };
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
