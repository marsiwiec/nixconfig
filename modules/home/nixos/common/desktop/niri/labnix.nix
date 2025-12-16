{ lib, config, ... }:
{
  config = lib.mkIf config.niri.enable {
    programs.niri = {
      settings = {
        outputs = {
          "DP-2" = {
            mode.width = 3440;
            mode.height = 1440;
            mode.refresh = 159.86;
          };
        };
      };
    };
  };
}
