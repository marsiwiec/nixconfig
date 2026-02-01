{
  config,
  inputs,
  ...
}:
{
  flake.modules.nixos.nixgroot =
    { config, ... }:
    {
      home-manager.sharedModules = [
        inputs.self.modules.homeManager.nixgroot
      ];
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
      ]
      ++ (with inputs.self.modules.generic; [
        systemConstants
      ])
      ++ (with inputs.self.modules.nixos; [
        boot
        sops
        msiwiec
      ]);

      networking.hostName = "nixgroot";

      sops = {
        secrets = {
          "syncthing/nixgroot/cert" = {
            owner = "${config.systemConstants.username}";
          };
          "syncthing/nixgroot/key" = {
            owner = "${config.systemConstants.username}";
          };
        };
      };

      services.syncthing = {
        key = "/run/secrets/syncthing/nixgroot/key";
        cert = "/run/secrets/syncthing/nixgroot/cert";
      };
      system.stateVersion = "24.11";
    };
  flake.modules.homeManager.nixgroot = {
    home.stateVersion = "24.11";
  };
}
