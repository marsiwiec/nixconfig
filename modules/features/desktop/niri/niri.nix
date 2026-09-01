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

        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
          wlr.enable = true;
          config = {
            common = {
              default = [
                "gtk"
                "gnome"
              ];
            };
            niri = {
              default = [
                "gtk"
                "gnome"
              ];
            };
          };
          extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-gtk
          ];
        };

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
        # NOTE: keybinds are chosen per-host (niri-keybinds-dms or niri-keybinds-noctalia)
        imports = with inputs.self.modules.homeManager; [
          niri-window-rules
        ];

        home.packages = with pkgs; [
          nerd-fonts.jetbrains-mono
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

          # spawn-at-startup = [
          #   { command = [ "${lib.getExe pkgs.sway-audio-idle-inhibit}" ]; }
          # ];

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

            # ThinkPad TrackPoint (TPPS/2 Synaptics). Driver-level tuning
            # (sensitivity/speed) lives in nixpad-laptop via hardware.trackpoint.
            trackpoint = {
              # Classic middle-button scrolling: hold the middle TrackPoint
              # button and push the stick. Replaces the X11-only
              # hardware.trackpoint.emulateWheel, which niri ignores.
              # A plain click (no stick movement) still sends a middle click.
              scroll-method = "on-button-down";
              scroll-button = 274; # BTN_MIDDLE
              # accel-speed: -1.0 to 1.0 (default 0.0)
              # accel-profile: "adaptive" (default) or "flat"
            };
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
