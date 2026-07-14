{
  flake.modules.homeManager.niri-keybinds-noctalia =
    { ... }:
    let
      nc = cmd: {
        action.spawn = [
          "noctalia"
          "msg"
        ] ++ cmd;
      };
      nc' =
        cmd: extraAttrs:
        (nc cmd) // extraAttrs;
    in
    {
      programs.niri.settings.binds = {
        # Noctalia panels
        "Mod+Space" = nc [ "panel-toggle" "launcher" ];
        "Mod+V" = nc [ "panel-toggle" "clipboard" ];
        "Mod+N" = nc [ "panel-toggle" "control-center" ];
        "Mod+P" = nc [ "panel-toggle" "noctalia/notes:panel" ];
        "Mod+X" = nc [ "panel-toggle" "session" ];
        "Mod+Comma" = nc [ "settings-toggle" ];
        "Ctrl+Alt+Delete" = nc [ "panel-toggle" "control-center" ];

        # App launchers
        "Mod+Return".action.spawn = [ "wezterm" ];
        "Mod+Shift+Return".action.spawn = [ "firefox" ];
        "Mod+W".action.spawn = [ "thunar" ];

        # Niri built-in actions
        "Mod+Shift+Backslash".action.show-hotkey-overlay = [ ];
        "Mod+Q".action.close-window = [ ];
        "Mod+F".action.fullscreen-window = [ ];
        "Mod+Shift+F".action.maximize-window-to-edges = [ ];
        "Mod+Shift+V".action.toggle-window-floating = [ ];
        "Mod+Shift+Print".action.expand-column-to-available-width = [ ];
        "Mod+Period".action.switch-preset-column-width = [ ];
        "Mod+Shift+E".action.quit = [ ];
        "Mod+O".action.toggle-overview = [ ];

        # Screenshots
        "Print" = nc [ "screenshot-fullscreen" ];
        "Mod+Print" = nc [ "screenshot-region" ];

        # Wallpaper
        "Mod+Y" = nc [ "panel-toggle" "wallpaper" ];

        # Color picker
        "Mod+C".action.spawn = [
          "hyprpicker"
          "-a"
        ];

        # Lock
        "Mod+Alt+L" = nc' [ "session" "lock" ] {
          allow-when-locked = true;
        };

        # Workspace focus
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;

        # Move column to workspace
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;

        # Window management
        "Mod+MouseMiddle".action.maximize-column = [ ];
        "Mod+Shift+C".action.center-window = [ ];
        "Mod+Shift+Comma".action.set-column-width = "-10%";
        "Mod+Shift+Period".action.set-column-width = "+10%";
        "Mod+Shift+Semicolon".action.set-window-height = "+10%";
        "Mod+Shift+Slash".action.set-window-height = "-10%";
        "Mod+J".action.consume-or-expel-window-left = [ ];
        "Mod+Semicolon".action.consume-or-expel-window-right = [ ];

        # Focus navigation
        "Mod+Shift+Left".action.focus-column-left = [ ];
        "Mod+Shift+Right".action.focus-column-right = [ ];
        "Mod+Shift+Down".action.focus-window-or-workspace-down = [ ];
        "Mod+Shift+Up".action.focus-window-or-workspace-up = [ ];

        # Mouse/scroll
        "Mod+WheelScrollLeft".action.focus-workspace-up = [ ];
        "Mod+WheelScrollRight".action.focus-workspace-down = [ ];

        "Mod+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Shift+WheelScrollDown".action.swap-window-right = [ ];
        "Mod+Shift+WheelScrollUp".action.swap-window-left = [ ];
        "Mod+Ctrl+F".action.move-column-to-first = [ ];
        "Mod+Ctrl+L".action.move-column-to-last = [ ];

        # Hardware keys (via noctalia, work when locked)
        "XF86AudioRaiseVolume" = nc' [ "volume-up" ] { allow-when-locked = true; };
        "XF86AudioLowerVolume" = nc' [ "volume-down" ] { allow-when-locked = true; };
        "XF86AudioMute" = nc' [ "volume-mute" ] { allow-when-locked = true; };
        "XF86AudioMicMute" = nc' [ "mic-mute" ] { allow-when-locked = true; };
        "XF86AudioNext" = nc' [ "media" "next" ] { allow-when-locked = true; };
        "XF86AudioPause" = nc' [ "media" "toggle" ] {
          allow-when-locked = true;
        };
        "XF86AudioPlay" = nc' [ "media" "toggle" ] {
          allow-when-locked = true;
        };
        "XF86AudioPrev" = nc' [ "media" "previous" ] {
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = nc' [ "brightness-up" ] {
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = nc' [ "brightness-down" ] {
          allow-when-locked = true;
        };
      };
    };

}
