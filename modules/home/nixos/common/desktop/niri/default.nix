{
  lib,
  config,
  pkgs,
  ...
}:
{

  imports = [
    ./binds.nix
    ./rules.nix
  ];

  options = {
    niri.enable = lib.mkEnableOption "niri hm config";
  };

  config = lib.mkIf config.niri.enable {

    # enable imported modules
    # mako.enable = true;

    # programs = {
    #   fuzzel.enable = true;
    #   swaylock.enable = true;
    # };

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      # pavucontrol
      # wl-clipboard
      # cliphist
      # playerctl
      # polkit_gnome
      # hyprpicker
      nautilus
      sway-audio-idle-inhibit
    ];

    services = {
      # hyprpaper.enable = true;
      udiskie = {
        enable = true;
        tray = "never";
      };
    };

    programs = {
      niri = {
        # enable = true;
        settings = {
          environment = {
            QT_QPA_PLATFORM = "wayland";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
            DMS_HIDE_TRAYIDS = "spotify-client";
          };

          spawn-at-startup = [
            # { command = [ "${lib.getExe pkgs.xwayland-satellite-unstable}" ]; }
            # {
            #   command = [ "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" ];
            # }
            { command = [ "${lib.getExe pkgs.sway-audio-idle-inhibit}" ]; }
            # {
            #   command = [
            #     "wl-paste"
            #     "--type"
            #     "text"
            #     "--watch"
            #     "cliphist"
            #     "store"
            #   ];
            # }
            # {

            #   command = [
            #     "wl-paste"
            #     "--type"
            #     "image"
            #     "--watch"
            #     "cliphist"
            #     "store"
            #   ];
            # }
            {
              command = [
                "sudo"
                "nvidia-enable"
              ];
            }
          ];

          prefer-no-csd = true;

          hotkey-overlay.skip-at-startup = true;

          input = {
            keyboard = {
              xkb = {
                layout = "pl";
                options = "caps:escape";
              };
            };
            focus-follows-mouse.enable = true;
            warp-mouse-to-focus.enable = true;
          };

          layout = {
            border = {
              enable = true;
              width = 3;
            };
            gaps = 4;
            always-center-single-column = true;
            struts = {
              left = 3;
              right = 3;
            };

            shadow.enable = true;

            background-color = "transparent";

            tab-indicator = {
              position = "top";
              gaps-between-tabs = 10;
              hide-when-single-tab = true;
            };
          };
        };
      };
    };
  };
}
