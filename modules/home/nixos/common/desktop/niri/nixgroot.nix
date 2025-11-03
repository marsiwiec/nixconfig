{ lib, config, ... }:
{
  config = lib.mkIf config.niri.enable {
    programs.niri = {
      settings = {
        outputs = {
          "DP-1" = {
            mode.width = 2560;
            mode.height = 1440;
            mode.refresh = 74.924004;
          };
          "HDMI-A-2" = {
            enable = false;
          };
        };

      };
    };
  };
}
