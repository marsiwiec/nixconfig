{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./nixcloud-disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  sops = {
    secrets = {
      syncthing_nixcloud_key.owner = "msiwiec";
      syncthing_nixcloud_cert.owner = "msiwiec";
    };
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.msiwiec = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFQmAOaTwMQFYKgNoqZZsn38CA1K2pjYUSgMRwuoWB8Y"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhqMJsbvGkm4cABlpXEDTqreLHQhafuaaohwR8YvWXI"
  ];

  services = {
    syncthing = {
      enable = true;
      user = "msiwiec";
      key = "/run/secrets/syncthing_nixcloud_key";
      cert = "/run/secrets/syncthing_nixcloud_cert";
      configDir = "/home/msiwiec/.config/syncthing"; # Folder for Syncthing's settings and keys. Will be overwritten by Nix!
      settings = {
        devices = {
          # Existing devices here!
          nixgroot = {
            name = "nixgroot";
            id = "OHDWGNL-ZKXTFC6-H4UD236-2ZNBQP6-FQFUOS6-QOVENNW-MTBLWP3-B2D4WA4";
          };
          labnix = {
            name = "labnix";
            id = "VS33NBI-U57M5JI-3BLPP7X-2PJ6HNG-VACPDFX-2MMJLGJ-NE5H4IY-5DCTDQR";
          };
          nixcloud = {
            name = "nixcloud";
            id = "BRKNJ2L-KUTOHBD-JI57IX5-42BTHTO-NNFIWNZ-ZUR5XZM-66GBYGX-FESONAH";
          };
        };
        folders = {
          zotero = {
            path = "/home/msiwiec/Documents/zotero";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
                cleanoutDays = "0";
              };
            };
            devices = [
              "nixgroot"
              "labnix"
            ];
          };
        };
      };
    };
  };
  systemd.user.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  system.stateVersion = "23.11";
}
