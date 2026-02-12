{
  inputs,
  lib,
  ...
}:
{
  flake.modules = {
    nixos.niri =
      { pkgs, ... }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.niri
        ];

        imports = [ inputs.self.modules.nixos.niri-module ];

        services.accounts-daemon.enable = true;

        systemd.user.services = {
          niri-flake-polkit.enable = false;
        };

        environment.systemPackages = with pkgs; [
          wl-clipboard
          wayland-utils
          libsecret
          cage
          xwayland-satellite
          swaybg
        ];

        programs = {
          niri = {
            enable = true;
            package = pkgs.niri-unstable;
          };
          seahorse.enable = true; # pass + encryption management
        };
      };

    homeManager.niri =
      {
        pkgs,
        ...
      }:
      {
        imports = with inputs.self.modules.homeManager; [
          # niri-keybinds
          niri-window-rules
        ];

        home.packages = with pkgs; [
          nerd-fonts.jetbrains-mono
          nautilus
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
  };
}
