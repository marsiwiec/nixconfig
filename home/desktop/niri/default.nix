{
  lib,
  config,
  pkgs,
  inputs,
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

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    # enable imported modules
    mako.enable = true;

    programs = {
      fuzzel.enable = true;
      swaylock.enable = true;
    };

    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      pavucontrol
      wl-clipboard
      cliphist
      playerctl
      polkit_gnome
      hyprpicker
    ];

    services = {
      hyprpaper.enable = true;
      udiskie = {
        enable = true;
        tray = "never";
      };
    };

    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
        settings = {

          environment = {
            QT_QPA_PLATFORM = "wayland";
            DISPLAY = ":0";
          };

          spawn-at-startup = [
            { command = [ "${lib.getExe pkgs.xwayland-satellite-unstable}" ]; }
            {
              command = [ "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" ];
            }
            {
              command = [
                "wl-paste"
                "--type"
                "text"
                "--watch"
                "cliphist"
                "store"
              ];
            }
            {

              command = [
                "wl-paste"
                "--type"
                "image"
                "--watch"
                "cliphist"
                "store"
              ];
            }
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
            focus-follows-mouse.enable = true;
          };

          layout = {
            border = {
              enable = true;
              width = 3;
            };
            gaps = 4;
            always-center-single-column = true;

            shadow.enable = true;
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
