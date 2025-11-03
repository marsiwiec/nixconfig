{ lib, config, ... }:
{
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        "monitor" = ",2560x1440@75,auto,auto";
      };
    };
  };
}
