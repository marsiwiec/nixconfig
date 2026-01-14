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
    home.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nautilus
      sway-audio-idle-inhibit
    ];

    services = {
      udiskie = {
        enable = true;
        tray = "never";
        settings = {
          program_options = {
            file_manager = "thunar";
          };
        };
      };
    };

    programs.niri.settings = {
      environment = {
        QT_QPA_PLATFORM = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      spawn-at-startup = [
        { command = [ "${lib.getExe pkgs.sway-audio-idle-inhibit}" ]; }
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
}
