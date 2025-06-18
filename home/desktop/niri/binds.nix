{ config, ... }:
{
  programs.niri = {
    settings = {
      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
        {
          "Mod+Space".action = spawn "fuzzel";
          "Mod+P".action = sh "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";
          "Mod+Return".action = spawn "wezterm";
          "Mod+Shift+Return".action = spawn "firefox";
          "Mod+W".action = spawn "thunar";

          "Mod+Shift+Backslash".action = show-hotkey-overlay;

          "Mod+Q".action = close-window;
          "Mod+F".action = fullscreen-window;
          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+Print".action = expand-column-to-available-width;
          "Mod+Shift+E".action = quit;
          "Print".action = screenshot;
          "Mod+Print".action = screenshot-window;

          "Mod+C".action = sh "hyprpicker -a";
          "Mod+Shift+L".action = sh "pidof swaylock || swaylock";

          "Mod+O".action = toggle-overview;

          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;

          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;

          "Mod+MouseMiddle".action = maximize-column;
          "Mod+Shift+C".action = center-window;
          "Mod+Shift+Comma".action.set-column-width = "-10%";
          "Mod+Shift+Period".action.set-column-width = "+10%";
          "Mod+Shift+Semicolon".action.set-window-height = "+10%";
          "Mod+Shift+Slash".action.set-window-height = "-10%";
          "Mod+J".action = consume-or-expel-window-left;
          "Mod+Semicolon".action = consume-or-expel-window-right;

          "Mod+Shift+Left".action = focus-column-left;
          "Mod+Shift+Right".action = focus-column-right;
          "Mod+Shift+Down".action = focus-window-or-workspace-down;
          "Mod+Shift+Up".action = focus-window-or-workspace-up;

          "Mod+WheelScrollLeft".action = focus-workspace-up;
          "Mod+WheelScrollRight".action = focus-workspace-down;

          "Mod+WheelScrollDown".action = focus-column-right;
          "Mod+WheelScrollUp".action = focus-column-left;
          "Mod+Shift+WheelScrollDown".action = move-column-left;
          "Mod+Shift+WheelScrollUp".action = move-column-right;

          "XF86AudioRaiseVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
          "XF86AudioLowerVolume".action.spawn = [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
          "XF86AudioMute".action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SINK"
            "toggle"
          ];
          "XF86AudioMicMute".action.spawn = [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE"
            "toggle"
          ];
          "XF86AudioNext".action.spawn = [
            "playerctl"
            "next"
          ];
          "XF86AudioPause".action.spawn = [
            "playerctl"
            "play-pause"
          ];
          "XF86AudioPlay".action.spawn = [
            "playerctl"
            "play-pause"
          ];
          "XF86AudioPrev".action.spawn = [
            "playerctl"
            "previous"
          ];
          "XF86MonBrightnessUp".action.spawn = [
            "ddcutil"
            "--bus=6"
            "setvcp"
            "10"
            "+"
            "10"
          ];
          "XF86MonBrightnessDown".action.spawn = [
            "ddcutil"
            "--bus=6"
            "setvcp"
            "10"
            "-"
            "10"
          ];

        };

    };
  };
}
