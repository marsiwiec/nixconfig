{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];
  ollama.enable = false;

  #### My own modules ####
  gaming.enable = false;
  sddm.enable = true;
  greetd.enable = false;

  networking.hostName = "labnix"; # Define your hostname.

  sops = {
    secrets = {
      "syncthing/labnix/cert" = {
        owner = "msiwiec";
      };
      "syncthing/labnix/key" = {
        owner = "msiwiec";
      };
    };
  };

  services = {
    syncthing = {
      key = "/run/secrets/syncthing/labnix/key";
      cert = "/run/secrets/syncthing/labnix/cert";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
