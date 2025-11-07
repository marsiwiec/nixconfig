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
          command = "noctalia-shell ipc call lockScreen lock";
        }
        {
          event = "lock";
          command = "noctalia-shell ipc call lockScreen lock";
        }
        {
          event = "after-resume";
          command = "${lib.getExe pkgs.niri} msg action power-on-monitors";
        }
      ];
      timeouts = [
        {
          timeout = 900;
          command = "noctalia-shell ipc call lockScreen lock";
        }
        {
          timeout = 1200;
          command = "${lib.getExe pkgs.niri} msg action power-off-monitors";
        }
      ];
    };
  };
}
