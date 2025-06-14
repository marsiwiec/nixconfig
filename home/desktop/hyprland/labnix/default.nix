{ lib, config, ... }:
{
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      settings = {
        "monitor" = ",preferred,auto,auto";
      };
    };
  };
}
