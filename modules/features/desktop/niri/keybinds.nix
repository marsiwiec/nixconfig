{
  lib,
  ...
}:
let
  # Per-shell panel parameters; everything that differs between the dms and
  # noctalia desktops lives here. `prefix` is prepended to every panel IPC
  # call, so a bind's argv is stored without its shell-specific prefix.
  panels = {
    dms = {
      prefix = [
        "dms"
        "ipc"
        "call"
      ];
      color = [
        "dms"
        "color"
        "pick"
        "-a"
      ];
      lock = [
        "lock"
        "lock"
      ];
      wallpaper = [
        "dankdash"
        "wallpaper"
      ];
      kill = true;
      toggles = {
        "Mod+Space" = [
          "spotlight"
          "toggle"
        ];
        "Mod+V" = [
          "clipboard"
          "toggle"
        ];
        "Mod+N" = [
          "notifications"
          "toggle"
        ];
        "Mod+P" = [
          "notepad"
          "toggle"
        ];
        "Mod+X" = [
          "powermenu"
          "toggle"
        ];
        "Mod+Comma" = [
          "settings"
          "toggle"
        ];
        "Ctrl+Alt+Delete" = [
          "processlist"
          "toggle"
        ];
      };
      screenshots = {
        "Print" = [
          "niri"
          "screenshot"
        ];
        "Mod+Print" = [
          "niri"
          "screenshotWindow"
        ];
      };
      hardware = {
        "XF86AudioRaiseVolume" = [
          "audio"
          "increment"
          "3"
        ];
        "XF86AudioLowerVolume" = [
          "audio"
          "decrement"
          "3"
        ];
        "XF86AudioMute" = [
          "audio"
          "mute"
        ];
        "XF86AudioMicMute" = [
          "audio"
          "micmute"
        ];
        "XF86AudioNext" = [
          "mpris"
          "next"
        ];
        "XF86AudioPause" = [
          "mpris"
          "playPause"
        ];
        "XF86AudioPlay" = [
          "mpris"
          "playPause"
        ];
        "XF86AudioPrev" = [
          "mpris"
          "previous"
        ];
        "XF86MonBrightnessUp" = [
          "brightness"
          "increment"
          "5"
        ];
        "XF86MonBrightnessDown" = [
          "brightness"
          "decrement"
          "5"
        ];
      };
    };
    noctalia = {
      prefix = [
        "noctalia"
        "msg"
      ];
      color = [
        "hyprpicker"
        "-a"
      ];
      lock = [
        "session"
        "lock"
      ];
      wallpaper = [
        "panel-toggle"
        "wallpaper"
      ];
      kill = false;
      toggles = {
        "Mod+Space" = [
          "panel-toggle"
          "launcher"
        ];
        "Mod+V" = [
          "panel-toggle"
          "clipboard"
        ];
        "Mod+N" = [
          "panel-toggle"
          "control-center"
        ];
        "Mod+P" = [
          "panel-toggle"
          "noctalia/notes:panel"
        ];
        "Mod+X" = [
          "panel-toggle"
          "session"
        ];
        "Mod+Comma" = [ "settings-toggle" ];
        "Ctrl+Alt+Delete" = [
          "panel-toggle"
          "control-center"
        ];
      };
      screenshots = {
        "Print" = [ "screenshot-fullscreen" ];
        "Mod+Print" = [ "screenshot-region" ];
      };
      hardware = {
        "XF86AudioRaiseVolume" = [ "volume-up" ];
        "XF86AudioLowerVolume" = [ "volume-down" ];
        "XF86AudioMute" = [ "volume-mute" ];
        "XF86AudioMicMute" = [ "mic-mute" ];
        "XF86AudioNext" = [
          "media"
          "next"
        ];
        "XF86AudioPause" = [
          "media"
          "toggle"
        ];
        "XF86AudioPlay" = [
          "media"
          "toggle"
        ];
        "XF86AudioPrev" = [
          "media"
          "previous"
        ];
        "XF86MonBrightnessUp" = [ "brightness-up" ];
        "XF86MonBrightnessDown" = [ "brightness-down" ];
      };
    };
  };
in
{
  # Factory aspect: full niri keybind set, parameterized by the desktop shell
  # (dms | noctalia). Returns a homeManager module for home-manager.sharedModules.
  config.flake.factory.niriKeybinds =
    mode:
    { config, ... }:
    let
      p = panels.${mode};
      panelSpawn = argv: {
        action.spawn = p.prefix ++ argv;
      };
      panelSpawnLocked = argv: (panelSpawn argv) // { allow-when-locked = true; };

      commonBinds = {
        # App launchers
        "Mod+Return".action.spawn = [ "wezterm" ];
        "Mod+Shift+Return".action.spawn = [ "firefox" ];
        "Mod+W".action.spawn = [ "thunar" ];

        # Niri built-in actions
        "Mod+Shift+Backslash".action.show-hotkey-overlay = [ ];
        "Mod+Q".action.close-window = [ ];
        "Mod+Escape".action.close-window = [ ];
        "Mod+F".action.fullscreen-window = [ ];
        "Mod+Shift+F".action.maximize-window-to-edges = [ ];
        "Mod+Shift+V".action.toggle-window-floating = [ ];
        "Mod+Shift+Print".action.expand-column-to-available-width = [ ];
        "Mod+Period".action.switch-preset-column-width = [ ];
        "Mod+Shift+E".action.quit = [ ];
        "Mod+O".action.toggle-overview = [ ];

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
      };

      panelBinds =
        (lib.mapAttrs (_: argv: panelSpawn argv) p.toggles)
        // (lib.mapAttrs (_: argv: panelSpawn argv) p.screenshots)
        // {
          # Wallpaper, color picker, lock
          "Mod+Y" = panelSpawn p.wallpaper;
          "Mod+C".action.spawn = p.color;
          "Mod+Alt+L" = panelSpawnLocked p.lock;
        }
        // (lib.mapAttrs (_: argv: panelSpawnLocked argv) p.hardware)
        // lib.optionalAttrs p.kill {
          # Kill quickshell (dms only)
          "Mod+Shift+Q" = with config.lib.niri.actions; {
            action = spawn "dms" "kill" "quickshell";
            allow-when-locked = true;
          };
        };
    in
    {
      programs.niri.settings.binds = commonBinds // panelBinds;
    };
}
