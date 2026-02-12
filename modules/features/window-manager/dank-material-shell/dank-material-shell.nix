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
            configHome = "/home/${username}";
            configFiles = [ "/home/${username}/.config/DankMaterialShell/settings.json" ];
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
            # niri = {
            #   # enableKeybinds = true;
            #   enableSpawn = true;
            # };
          };
        };
        xdg.configFile."DankMaterialShell/stylix.json".source =
          with config.lib.stylix.colors.withHashtag;
          lib.mkIf config.stylix.enable (
            pkgs.writers.writeJSON "custom-theme.json" {
              "name" = "Stylix";
              "primary" = base0C;
              "primaryText" = base00;
              "primaryContainer" = base0D;
              "secondary" = base0E;
              "surface" = base00;
              "surfaceText" = base05;
              "surfaceVariant" = base01;
              "surfaceVariantText" = base04;
              "surfaceTint" = base0C;
              "background" = base00;
              "backgroundText" = base07;
              "outline" = base03;
              "surfaceContainer" = base01;
              "surfaceContainerHigh" = base02;
              "error" = base08;
              "warning" = base0A;
              "info" = base0D;
            }
          );
      };
  };
}
