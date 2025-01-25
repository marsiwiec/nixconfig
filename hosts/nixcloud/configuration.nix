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
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      "syncthing/nixcloud/key" = {
        owner = "msiwiec";
      };
      "syncthing/nixcloud/cert" = {
        owner = "msiwiec";
      };
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
      key = "/run/secrets/syncthing/nixcloud/key";
      cert = "/run/secrets/syncthing/nixcloud/cert";
      configDir = "/home/msiwiec/.config/syncthing"; # Folder for Syncthing's settings and keys. Will be overwritten by Nix!
      settings = {
        devices = {
          # Existing devices here!
          nixgroot = {
            name = "nixgroot";
            id = "EWRXSIL-W2OZVRK-PYS6ATQ-76MKITY-JJFMEBO-BKMPEQJ-JEUAURW-FM67XAN";
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
