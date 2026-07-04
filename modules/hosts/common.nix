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

      # APC UPS monitoring and safety features
      services.apcupsd.enable = true;

      # Ensure syncthing starts after sops secrets are available
      systemd.services.syncthing = {
        after = [ "sops-install-secrets.service" ];
        requires = [ "sops-install-secrets.service" ];
      };
    };
}
