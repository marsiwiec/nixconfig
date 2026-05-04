{ inputs, ... }:
{
  flake.modules = {
    nixos.dank-material-shell =
      {
        config,
        pkgs,
        ...
      }:
      let
        username = config.systemConstants.username;
        userhome = "/home/${username}";
      in
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.dank-material-shell
        ];
        imports = [
          inputs.dank-material-shell.nixosModules.greeter
        ];
        programs = {
          dank-material-shell.greeter = {
            enable = true;
            compositor.name = "niri";
            configHome = "${userhome}";
            configFiles = [ "${userhome}/.config/DankMaterialShell/settings.json" ];
            logs = {
              save = true;
              path = "/tmp/dms-greeter.log";
            };
          };

          dsearch = {
            enable = true;
            systemd.enable = true;
          };
        };

        ### Stuff below is for unlocking github and gitea ssh passkeys on login
        # as per https://discourse.nixos.org/t/gpg-ssh-gnome-keyring-recommendation/48647/8
        services.gnome.gnome-keyring.enable = true;
        security.pam.services = {
          login.enableGnomeKeyring = true;
          greetd.enableGnomeKeyring = true;
          greetd-password.enableGnomeKeyring = true;
        };
        services.dbus.packages = with pkgs; [
          gnome-keyring
          gcr
        ];

      };
    homeManager.dank-material-shell =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        imports = [
          inputs.dank-material-shell.homeModules.dank-material-shell
          inputs.dank-material-shell.homeModules.niri
        ];

        home.sessionVariables = {
          DMS_HIDE_TRAYIDS = "spotify-client";
        };
        programs = {
          dank-material-shell = {
            enable = true;
            systemd.enable = true;
            enableCalendarEvents = false; # temp khal bug
            settings = {
              use24HourClock = true;
              animationSpeed = 0;
              maxWorkspaceIcons = 3;
              audioVisualizerEnabled = false;
              clockCompactMode = false;
              appsDockEnlargePercentage = 125;
              weatherEnabled = false;
              showWeather = false;
              notepadFontSize = 18;
              acMonitorTimeout = 3600;
              acLockTimeout = 1200;
              lockBeforeSuspend = true;
              loginctlLockIntegration = true;
              fadeToLockEnabled = true;
              fadeToLockGracePeriod = 5;
              fadeToDpmsEnabled = true;
              fadeToDpmsGracePeriod = 5;
              launcherLogoMode = "os";
              showWorkspacePadding = true;
              muxType = "zellij";

              barConfigs = [
                {
                  id = "default";
                  name = "Main Bar";
                  enabled = true;
                  position = 0;
                  screenPreferences = [
                    "all"
                  ];
                  showOnLastDisplay = true;
                  leftWidgets = [
                    "launcherButton"
                    "workspaceSwitcher"
                    "focusedWindow"
                  ];
                  centerWidgets = [
                    {
                      id = "clock";
                      enabled = true;
                      clockCompactMode = false;
                    }
                  ];
                  rightWidgets = [
                    {
                      id = "music";
                      enabled = true;
                      mediaSize = 3;
                    }
                    {
                      id = "spacer";
                      enabled = true;
                      size = 20;
                    }
                    {
                      id = "controlCenterButton";
                      enabled = true;
                    }
                    {
                      id = "spacer";
                      enabled = true;
                      size = 20;
                    }
                    {
                      id = "dankPomodoroTimer";
                      enabled = true;
                    }
                    {
                      id = "idleInhibitor";
                      enabled = true;
                    }
                    {
                      id = "spacer";
                      enabled = true;
                      size = 20;
                    }
                    {
                      id = "cpuUsage";
                      enabled = true;
                      minimumWidth = true;
                    }
                    {
                      id = "memUsage";
                      enabled = true;
                      showSwap = false;
                    }
                    {
                      id = "diskUsage";
                      enabled = true;
                    }
                    {
                      id = "spacer";
                      enabled = true;
                      size = 20;
                    }
                    {
                      id = "dockerManager";
                      enabled = true;
                    }
                    {
                      id = "systemTray";
                      enabled = true;
                    }
                    {
                      id = "notificationButton";
                      enabled = true;
                    }
                    {
                      id = "powerMenuButton";
                      enabled = true;
                    }
                  ];
                  spacing = 4;
                  innerPadding = 8;
                  fontScale = 1.15;
                }
              ];

              controlCenterWidgets = [
                {
                  id = "volumeSlider";
                  enabled = true;
                  width = 50;
                }
                {
                  id = "brightnessSlider";
                  enabled = true;
                  width = 50;
                }
                {
                  id = "wifi";
                  enabled = true;
                  width = 50;
                }
                {
                  id = "bluetooth";
                  enabled = true;
                  width = 50;
                }
                {
                  id = "audioOutput";
                  enabled = true;
                  width = 50;
                }
                {
                  id = "nightMode";
                  enabled = true;
                  width = 50;
                }
              ];
            };
          };
        };
      };
  };
}
