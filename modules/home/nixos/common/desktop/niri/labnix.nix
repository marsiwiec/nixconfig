{ lib, config, ... }:
{
  config = lib.mkIf config.niri.enable {
    programs.niri = {
      settings = {
        outputs = {
          "DP-2" = {
            mode = {
              width = 3440;
              height = 1440;
              refresh = 159.86;
            };
            focus-at-startup = true;
          };
          "HDMI-A-1" = {
            enable = false;
          };
        };
      };
    };
  };
}
