{ inputs, ... }:
{
  flake.modules = {
    nixos.noctalia =
      { config, pkgs, ... }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.noctalia
        ];
        imports = [
          inputs.noctalia-greeter.nixosModules.default
        ];
        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          ];
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

        programs.noctalia-greeter = {
          enable = true;
          package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
          settings.cursor = {
            theme = config.stylix.cursor.name;
            size = config.stylix.cursor.size;
            package = config.stylix.cursor.package;
          };
        };
      };
    homeManager.noctalia = {
      imports = [
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };
    };
  };
}
