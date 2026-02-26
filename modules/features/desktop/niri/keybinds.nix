{
  flake.modules.homeManager.niri-keybinds =
    let
      dms = cmd: args: {
        action.spawn = [
          "dms"
          "ipc"
          "call"
          cmd
        ]
        ++ args;
      };
      dms' =
        cmd: args: extraAttrs:
        (dms cmd args) // extraAttrs;
    in
    {
      programs.niri.settings.binds = {
        # "Mod+Space"= "fuzzel";
        "Mod+Space" = dms "spotlight" ["toggle"];
        "Mod+V" = dms "clipboard" ["toggle"];
        "Mod+Return".action.spawn = ["wezterm"];
        "Mod+Shift+Return".action.spawn = ["firefox"];
        "Mod+W".action.spawn = ["thunar"];

        "Mod+Shift+Backslash".action.show-hotkey-overlay = [ ];
        "Mod+N" = dms "notifications" ["toggle"];
        "Mod+P" = dms "notepad" ["toggle"];
        "Mod+X" = dms "powermenu" ["toggle"];
        "Mod+Comma" = dms "settings" ["toggle"];
        "Ctrl+Alt+Delete" = dms "processlist" ["toggle"];

        "Mod+Q".action.close-window = [ ];
        "Mod+F".action.fullscreen-window = [ ];
        "Mod+Shift+F".action.maximize-window-to-edges = [ ];
        "Mod+Shift+V".action.toggle-window-floating = [ ];
        "Mod+Shift+Print".action.expand-column-to-available-width = [ ];
        "Mod+Period".action.switch-preset-column-width = [ ];
        "Mod+Shift+E".action.quit = [ ];
        "Print" = dms "niri" [ "screenshot" ];
        "Mod+Print" = dms "niri" [ "screenshotWindow" ];
        "Mod+Y" = dms "dankdash" ["wallpaper"];

        "Mod+C" = dms "color" ["pick"];
        "Mod+Alt+L" = dms' "lock" ["lock"] {
          allow-when-locked = true;
        };

        "Mod+O".action.toggle-overview = [ ];

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

        "Mod+MouseMiddle".action.maximize-column = [ ];
        "Mod+Shift+C".action.center-window = [ ];
        "Mod+Shift+Comma".action.set-column-width = "-10%";
        "Mod+Shift+Period".action.set-column-width = "+10%";
        "Mod+Shift+Semicolon".action.set-window-height = "+10%";
        "Mod+Shift+Slash".action.set-window-height = "-10%";
        "Mod+J".action.consume-or-expel-window-left = [ ];
        "Mod+Semicolon".action.consume-or-expel-window-right = [ ];

        "Mod+Shift+Left".action.focus-column-left = [ ];
        "Mod+Shift+Right".action.focus-column-right = [ ];
        "Mod+Shift+Down".action.focus-window-or-workspace-down = [ ];
        "Mod+Shift+Up".action.focus-window-or-workspace-up = [ ];

        "Mod+WheelScrollLeft".action.focus-workspace-up = [ ];
        "Mod+WheelScrollRight".action.focus-workspace-down = [ ];

        "Mod+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Shift+WheelScrollDown".action.swap-window-right = [ ];
        "Mod+Shift+WheelScrollUp".action.swap-window-left = [ ];
        "Mod+Ctrl+F".action.move-column-to-first = [ ];
        "Mod+Ctrl+L".action.move-column-to-last = [ ];

        "XF86AudioRaiseVolume" = dms' "audio" [ "increment" "3" ] { allow-when-locked = true; };
        "XF86AudioLowerVolume" = dms' "audio" [ "decrement" "3" ] { allow-when-locked = true; };
        "XF86AudioMute" = dms' "audio" [ "mute" ] { allow-when-locked = true; };
        "XF86AudioMicMute" = dms' "audio" [ "micmute" ] { allow-when-locked = true; };
        "XF86AudioNext" = dms' "mpris" [ "next" ] { allow-when-locked = true; };
        "XF86AudioPause" = dms' "mpris" [ "playPause" ] {
          allow-when-locked = true;
        };
        "XF86AudioPlay" = dms' "mpris" [ "playPause" ] {
          allow-when-locked = true;
        };
        "XF86AudioPrev" = dms' "mpris" [ "previous" ] {
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = dms' "brightness" [ "increment" "5" ] {
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = dms' "brightness" [ "decrement" "5" ] {
          allow-when-locked = true;
        };
      };
    };

}
