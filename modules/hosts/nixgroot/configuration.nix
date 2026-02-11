{
  config,
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.nixgroot =
      {
        config,
        pkgs,
        ...
      }:
      {
        home-manager.sharedModules.nixgroot = [
          inputs.self.modules.homeManager.nixgroot
        ];
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
        ]
        ++ (with inputs.self.modules.generic; [
          nix-settings
          # stylix
          syncthing
        ])
        ++ (with inputs.self.modules.nixos; [
          default-settings
          # audio
          # bluetooth
          # boot
          # fonts
          # gaming
          # graphics
          hardware-nixgroot
          # keyboard
          # locale
          # logitech
          msiwiec
          # networking
          nvidia
          nvidia-enable
          # power
          # printing
          # screen
          # security-defaults
          # ssh
          # sops
          # stylix
          # systemConstants
          # tailscale
          # time
          # vfio
          # virtualisation
        ]);

        networking.hostName = "nixgroot";
        stylix = {
          image = config.systemConstants.wallpaperDir;
          base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
        };

        # sops = {
        #   secrets = {
        #     "syncthing/nixgroot/cert" = {
        #       owner = config.systemConstants.username;
        #     };
        #     "syncthing/nixgroot/key" = {
        #       owner = config.systemConstants.username;
        #     };
        #   };
        # };

        services.syncthing = {
          key = "/run/secrets/syncthing/nixgroot/key";
          cert = "/run/secrets/syncthing/nixgroot/cert";
        };
        system.stateVersion = "24.11";
      };
    homeManager.nixgroot = {
      imports = with inputs.self.modules.homeManager; [
        msiwiec
      ];
      home.stateVersion = "24.11";
    };
  };
}
