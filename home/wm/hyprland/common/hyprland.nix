{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enable home-manager config for hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs = {
      fuzzel.enable = true;
      hyprlock.enable = true;
    };

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      pavucontrol
      wl-clipboard
      playerctl
      hyprpaper
      hyprpicker
      polkit_gnome
    ];

    services.mako.enable = true;
    services.udiskie = {
      enable = true;
      tray = "never";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        "$mod" = "SUPER";
        "$terminal" = "wezterm";
        "$fileManager" = "thunar";
        exec-once = [
          "uwsm app -- ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
          "uwsm app -- waybar"
          "uwsm app -- mako"
          "uwsm app -- hyprpaper"
          "uwsm app -- wl-paste --type text --watch cliphist store # Stores only text data"
          "uwsm app -- wl-paste --type image --watch cliphist store # Stores only image data"
          "sudo nvidia-enable"
        ];

        general = {
          gaps_in = 2;
          gaps_out = 4;
          border_size = 3;
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };

        input = {
          kb_layout = "pl";
          kb_options = "caps:escape";
          follow_mouse = 1;
          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = [
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
          ];
          animation = [
            "windows, 1, 5, overshot, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "windowsMove, 1, 4, default"
            "border, 1, 10, default"
            "fade, 1, 10, smoothIn"
            "fadeDim, 1, 10, smoothIn"
            "workspaces, 1, 6, default"
          ];
        };
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        dwindle = {
          pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # You probably want this
        };

        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        ###################
        ### KEYBINDINGS ###
        ###################
        submap = [
          "passthru"
          "reset"
        ];
        bind = [
          "$mod, RETURN, exec, uwsm app -- $terminal"
          "$mod, Q, killactive"
          "$mod SHIFT, E, exec, uwsm stop"
          "$mod, W, exec, uwsm app -- $fileManager"
          "$mod SHIFT, B, exec, uwsm app -- waybar"
          "$mod SHIFT, Return, exec, uwsm app -- firefox"
          "$mod, V, togglefloating"
          "$mod, SPACE, exec, uwsm app -- fuzzel || uwsm app -- pkill fuzzel"
          "$mod, P, pseudo" # dwindle
          "$mod, O, swapsplit"
          "$mod, J, togglesplit" # dwindle
          "$mod, C, exec, uwsm app -- hyprpicker -a"
          "$mod SHIFT, L, exec, uwsm app -- pidof hyprlock || uwsm app -- hyprlock"
          "$mod, F, fullscreen"

          "$mod SHIFT, P, submap, passthru" # Passthrough SUPER key to VM
          "SUPER, Escape, submap, reset" # Reset passthrough"

          # Switch workspaces with mod + [0-9]
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move active window to a workspace with mod + SHIFT + [0-9]
          "$mod SHIFT, 1, movetoworkspacesilent, 1"
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"

          # Example special workspace (scratchpad)
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mod + scroll. Also using arrow keys
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, left, workspace, e-1"
          "$mod, right, workspace, e+1"

          # switch between windows with mod SHIFT + arrow keys
          "$mod SHIFT, left, movefocus, l"
          "$mod SHIFT, right, movefocus, r"
          "$mod SHIFT, up, movefocus, u"
          "$mod SHIFT, down, movefocus, d"

          # resize active window
          "$mod SHIFT, Comma, resizeactive, -20 0"
          "$mod SHIFT, Period, resizeactive, 20 0"
          "$mod SHIFT, Semicolon, resizeactive, 0 -20"
          "$mod SHIFT, Slash, resizeactive, 0 20"
        ];

        bindm = [
          # Move/resize windows with mod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindel = [
          # Laptop multimedia keys for volume and LCD brightness
          ", XF86AudioRaiseVolume, exec, uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
          ", XF86AudioLowerVolume, exec, uwsm app -- wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, uwsm app -- wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, uwsm app -- wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ];

        bindl = [
          # Requires playerctl
          ", XF86AudioNext, exec, uwsm app -- playerctl next"
          ", XF86AudioPause, exec, uwsm app -- playerctl play-pause"
          ", XF86AudioPlay, exec, uwsm app -- playerctl play-pause"
          ", XF86AudioPrev, exec, uwsm app -- playerctl previous"
        ];
        ##############################
        ### WINDOWS AND WORKSPACES ###
        ##############################
        workspace = [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ];

        windowrulev2 = [
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"

          "opacity 0.95, class:^(kitty)$"
          "opacity 0.95, class:^(foot)$"
          "opacity 0.95, class:^(ghostty)$"
          "opacity 0.95, class:^(thunar)$"
          "idleinhibit, fullscreen: 1"
          "float, title:^(Picture-in-Picture)$"
          "move 1556 835, title:^(Picture-in-Picture)$"
          "size 1000 600, title:^(Picture-in-Picture)$"
          "pin, title:^(Picture-in-Picture)$"

          "workspace 6, title:^(Steam)$"

          "workspace 7, class:^(org.inkscape.Inkscape)$"
          "workspace 7, class:^(Gimp-2.10)$"

          "workspace 8, title:^(RStudio)$"
          "workspace 8, title:^(Positron)$"
          "workspace 9, class:^(looking-glass-client)$"
          "workspace 10, class:^(spotify)$"
          "suppressevent maximize, class:.*" # You'll probably like this.

          ##########################
          # Misc. floating windows #
          ##########################
          "float,title:^(Open File)$"
          "float,title:^(Save File)$"
          "float,title:^(Save As)$"
          "float,title:^(Open)$"
          "float,title:^(Save$)"
          "float,title:^(Save Image$)"
          "float,title:^(Save Image As$)"
          "float,title:^(Progress$)"
          "float,class:^(download)$"
          "float,class:^(confirm)$"
        ];
      };
    };
  };
}
