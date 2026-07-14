{ inputs, ... }:
{
  flake.modules.nixos.noctalia = {

    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    imports = [
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      recommendedServices.enable = true;
    };

    programs.noctalia-greeter = {
      enable = true;
    };
  };
}
