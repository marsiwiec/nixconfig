{
  lib,
  config,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors;
in
{
  options = {
    waybar.enable = lib.mkEnableOption "enable waybar status bar config";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-left = [
            "custom/os_button"
            "hyprland/workspaces"
            "niri/workspaces"
            "hyprland/window"
            "niri/window"
          ];
          modules-center = [
            "clock"
          ];
          modules-right = [
            "mpris"
            "pulseaudio"
            "network"
            "disk"
            "cpu"
            "memory"
            "idle_inhibitor"
            "tray"
          ];
          "custom/os_button" = {
            format = "<big>󱄅</big>";
            on-click = "fuzzel || pkill fuzzel";
            tooltip = false;
          };
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "6" = "󰓓";
              "7" = "󰖲";
              "8" = "󰟔";
              "9" = "󰖳";
              "10" = "󰝚";
            };
          };
          "hyprland/window" = {
            format = "  {}";
            max-length = 50;
          };
          "niri/window" = {
            format = "  {}";
            max-length = 50;
          };
          "clock" = {
            format = "{:%H:%M}";
            format-alt = "{:%a, %d. %b %Y - %H:%M}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            locale = "en_GB.UTF-8";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "";
              on-scroll = 1;
              format = {
                months = "<span color='#${colors.base0E}'><b>{}</b></span>";
                days = "<span color='#${colors.base05}'><b>{}</b></span>";
                weekdays = "<span color='#${colors.base0D}'><b>{}</b></span>";
                today = "<span color='#${colors.base0A}'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = [
                "tz_up"
                "shift_up"
              ];
              on-scroll-down = [
                "tz_down"
                "shift_down"
              ];
            };
          };
          mpris = {
            format = "{status_icon} {title} - {artist}";
            max-length = 50;
            status-icons = {
              playing = "󰐊";
              paused = "󰏤";
            };
            interval = 1;
            ignored-players = [
              "firefox"
            ];
          };
          pulseaudio = {
            format = "{icon} {volume}%";
            format-bluetooth = " {volume}%";
            format-muted = "";
            format-icons = {
              headphone = "";
              default = [
                ""
                ""
                " "
              ];
            };
            scroll-step = 1;
            max-volume = 100;
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            ignored-sinks = [
              "Easy Effects Sink"
            ];
          };
          network = {
            format = "{ifname}";
            format-wifi = "  {signalStrength}%";
            format-ethernet = "󰊗 {ipaddr}/{cidr}";
            format-disconnected = "󰖪";
            tooltip-format = "{ifname} via {gwaddr}";
            tooltip-format-wifi = "{essid} ({signalStrength}%)";
            tooltip-format-ethernet = "{ifname}";
            tooltip-format-disconnected = "Disconnected";
            max-length = 50;
          };
          disk = {
            interval = 30;
            format = "  {percentage_used}%";
            path = "/";
          };
          cpu = {
            format = "  {usage}%";
          };
          memory = {
            format = "  {}%";
          };
          tray = {
            icon-size = 20;
            spacing = 15;
          };
          idle_inhibitor = {
            format = "<big>{icon}</big>";
            format-icons = {
              activated = "󰅶";
              deactivated = "󰛊";
            };
          };
        }
      ];
      style = ''
        #workspaces button {
          margin-left: 0.25em;
          margin-right: 0.25em;
        }


        #tray {
          margin-right: 10px;
          margin-left: 10px;
        }

        #pulseaudio, #network, #disk, #memory, #cpu, #custom-pacman, #idle_inhibitor {
          margin-right: 10px;
          margin-left: 10px;
        }

        #mpris {
          margin-right: 20px;
          margin-left: 5px;
        }

        #custom-os_button {
          margin-right: 10px;
          margin-left: 10px;
        }

        #window {
          margin-left: 15px;
        }
      '';
    };
  };
}
