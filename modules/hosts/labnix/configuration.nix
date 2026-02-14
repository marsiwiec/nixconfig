{
  inputs,
  ...
}:
{
  flake.modules = {
    nixos.labnix =
      {
        config,
        pkgs,
        ...
      }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.niri-outputs-labnix
        ];
        imports = [
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
        ]
        ++ (with inputs.self.modules.generic; [
          nix-settings
        ])
        ++ (with inputs.self.modules.nixos; [
          default-settings
          labnix-filesystem
          msiwiec
        ]);

        networking.hostName = "labnix";
        stylix = {
          image = "${config.systemConstants.wallpaperDir}/star_wars.png";
          base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
        };

        sops = {
          secrets = {
            "syncthing/labnix/cert" = {
              owner = config.systemConstants.username;
            };
            "syncthing/labnix/key" = {
              owner = config.systemConstants.username;
            };
          };
        };

        services.syncthing = {
          key = "/run/secrets/syncthing/labnix/key";
          cert = "/run/secrets/syncthing/labnix/cert";
        };

        hardware.enableRedistributableFirmware = true;
        system.stateVersion = "24.11";
      };
  };
}
