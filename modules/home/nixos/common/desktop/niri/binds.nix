{
  config,
  osConfig,
  ...
}:
{
  programs.niri = {
    settings = {
      binds =
        with config.lib.niri.actions;
        let
          monitor = if osConfig.networking.hostName == "nixgroot" then "ddc:i2c-5" else "";
        in
        {
          # "Mod+Space".action = spawn "fuzzel";
          "Mod+Space".action = spawn "dms" "ipc" "call" "spotlight" "toggle";
          "Mod+V".action = spawn "dms" "ipc" "call" "clipboard" "toggle";
          "Mod+Return".action = spawn "wezterm";
          "Mod+Shift+Return".action = spawn "firefox";
          "Mod+W".action = spawn "thunar";

          "Mod+Shift+Backslash".action = show-hotkey-overlay;
          "Mod+M".action = spawn "dms" "ipc" "call" "processlist" "toggle";
          "Mod+N".action = spawn "dms" "ipc" "call" "notifications" "toggle";
          "Mod+P".action = spawn "dms" "ipc" "call" "notepad" "toggle";
          "Mod+X".action = spawn "dms" "ipc" "call" "powermenu" "toggle";
          "Mod+Comma".action = spawn "dms" "ipc" "call" "settings" "toggle";
          "Ctrl+Alt+Delete".action = spawn "dms" "ipc" "call" "processlist" "toggle";

          "Mod+Q".action = close-window;
          "Mod+F".action = fullscreen-window;
          "Mod+Shift+V".action = toggle-window-floating;
          "Mod+Shift+Print".action = expand-column-to-available-width;
          "Mod+Period".action = switch-preset-column-width;
          "Mod+Shift+E".action = quit;
          "Print".action = spawn "dms" "screenshot" "full";
          "Mod+Print".action = spawn "dms" "screenshot" "region";
          "Mod+Y".action = spawn "dms" "ipc" "call" "dankdash" "wallpaper";

          "Mod+C".action = spawn "dms" "color" "pick";
          "Mod+Alt+L".action = spawn "dms" "ipc" "call" "lock" "lock";

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
          "Mod+Shift+WheelScrollDown".action = swap-window-right;
          "Mod+Shift+WheelScrollUp".action = swap-window-left;
          "Mod+Ctrl+F".action = move-column-to-first;
          "Mod+Ctrl+L".action = move-column-to-last;

          "XF86AudioRaiseVolume" = {
            action = spawn "dms" "ipc" "call" "audio" "increment" "3";
            allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = spawn "dms" "ipc" "call" "audio" "decrement" "3";
            allow-when-locked = true;
          };
          "XF86AudioMute" = {
            action = spawn "dms" "ipc" "call" "audio" "mute";
            allow-when-locked = true;
          };
          "XF86AudioMicMute" = {
            action = spawn "dms" "ipc" "call" "audio" "micmute";
            allow-when-locked = true;
          };
          "XF86AudioNext" = {
            action = spawn "dms" "ipc" "call" "mpris" "next";
            allow-when-locked = true;
          };
          "XF86AudioPause" = {
            action = spawn "dms" "ipc" "call" "mpris" "playPause";
            allow-when-locked = true;
          };
          "XF86AudioPlay" = {
            action = spawn "dms" "ipc" "call" "mpris" "playPause";
            allow-when-locked = true;
          };
          "XF86AudioPrev" = {
            action = spawn "dms" "ipc" "call" "mpris" "previous";
            allow-when-locked = true;
          };
          "XF86MonBrightnessUp" = {
            action = spawn "dms" "ipc" "call" "brightness" "increment" "5" "${monitor}";
            allow-when-locked = true;
          };
          "XF86MonBrightnessDown" = {
            action = spawn "dms" "ipc" "call" "brightness" "decrement" "5" "${monitor}";
            allow-when-locked = true;
          };
        };
    };
  };
}
