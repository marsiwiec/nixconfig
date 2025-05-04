{
  lib,
  config,
  ...
}:
{
  options = {
    waybar.enable = lib.mkEnableOption "enable waybar status bar config";
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-left = [
            "custom/os_button"
            "hyprland/workspaces"
            "hyprland/window"
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
            on-click = "uwsm app -- fuzzel || uwsm app -- pkill fuzzel";
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
                months = "<span color='#A7C080'><b>{}</b></span>";
                days = "<span color='#D3C6AA'><b>{}</b></span>";
                weekdays = "<span color='#D699B6'><b>{}</b></span>";
                today = "<span color='#E69875'><b><u>{}</u></b></span>";
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
            on-click = "uwsm app -- nm-connection-editor";
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
