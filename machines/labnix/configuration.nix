{
  inputs,
  outputs,
  vars,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../style/stylix/labnix

    ./hardware-configuration.nix
    ../../modules/system/nixos
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs vars; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${vars.userName} = {
        imports = [
          ../../modules/home/nixos
        ];
      };
    };
  };
  #### My own modules ####
  nvidia.enable = false;
  nvidia-enable.enable = false;
  vfio.enable = false;
  virtualisation.kvmfr.enable = false;
  gaming.enable = false;
  ollama.enable = false;

  networking.hostName = "labnix";

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
