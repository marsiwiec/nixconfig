{ pkgs, ... }:
{
  programs.waybar.enable = true;
  services.mako.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    pavucontrol
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    settings = {
      "\$mod" = "SUPER";
      "\$terminal" = "kitty";
      "\$fileManager" = "dolphin";
      "monitor" = ",preferred,auto,auto";
      input = {
        kb_layout = "pl";
        kb_options = "caps:escape";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };
      exec-once = [
        "waybar"
        "mako"
      ];

      ###################
      ### KEYBINDINGS ###
      ###################
      bind = [
        "$mod, RETURN, exec, $terminal"
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, W, exec, $fileManager"
        "$mod SHIFT, Return, exec, firefox"
        "$mod, V, togglefloating"
        "$mod, SPACE, exec, rofi -show drun || pkill rofi"
        "$mod, P, pseudo" # dwindle
        "$mod, J, togglesplit" # dwindle
        "$mod, C, exec, hyprpicker -a"
        "$mod SHIFT, L, exec, pidof hyprlock || hyprlock"
        "$mod, F, fullscreen"
        "$mod SHIFT, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

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

        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        # "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        # Laptop multimedia keys for volume and LCD brightness
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        # Requires playerctl
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"

      ];
      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################
      windowrulev2 = [
        "idleinhibit, fullscreen: 1"
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

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
}
