{
  flake.modules.nixos.host-common =
    { config, ... }:
    {
      hardware.enableRedistributableFirmware = true;
      system.stateVersion = "26.05";

      sops = {
        secrets = {
          "syncthing/${config.networking.hostName}/cert" = {
            owner = config.systemConstants.username;
          };
          "syncthing/${config.networking.hostName}/key" = {
            owner = config.systemConstants.username;
          };
        };
      };

      services.syncthing = {
        key = "/run/secrets/syncthing/${config.networking.hostName}/key";
        cert = "/run/secrets/syncthing/${config.networking.hostName}/cert";
      };
    };
}
