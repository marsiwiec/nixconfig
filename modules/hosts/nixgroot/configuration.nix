{
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
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.looking-glass
          inputs.self.modules.homeManager.niri-outputs-nixgroot
        ];
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
        ]
        ++ (with inputs.self.modules.generic; [
          nix-settings
          syncthing
        ])
        ++ (with inputs.self.modules.nixos; [
          default-settings
          gaming
          msiwiec
          nixgroot-filesystem
          nvidia
          nvidia-enable
          vfio
        ]);

        networking.hostName = "nixgroot";
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/flowers.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
        };

        sops = {
          secrets = {
            "syncthing/nixgroot/cert" = {
              owner = config.systemConstants.username;
            };
            "syncthing/nixgroot/key" = {
              owner = config.systemConstants.username;
            };
          };
        };

        services.syncthing = {
          key = "/run/secrets/syncthing/nixgroot/key";
          cert = "/run/secrets/syncthing/nixgroot/cert";
        };
        system.stateVersion = "24.11";
      };
  };
}
