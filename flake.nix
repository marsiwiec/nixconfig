{
  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    niri.url = "github:sodiboo/niri-flake";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      vars = import ./vars.nix;

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkNixOSConfig =
        path:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs vars; };
          modules = [
            inputs.stylix.nixosModules.stylix
            ./style/stylix
            path
          ];
        };

      mkDarwinConfig =
        path:
        nixpkgs.lib.darwinSystem {
          specialArgs = { inherit inputs outputs vars; };
          modules = [ path ];
        };
    in
    {
      nixosConfigurations = {
        ### Home desktop ###
        nixgroot = mkNixOSConfig ./hosts/nixgroot/configuration.nix;
        labnix = mkNixOSConfig ./hosts/labnix/configuration.nix;
      };
      # ### Hetzner Cloud ###
      # nixcloud = inputs.nixpkgs.lib.nixosSystem {
      #   modules = [
      #     { nixpkgs.hostPlatform = "x86_64-linux"; }
      #     disko.nixosModules.disko
      #     sops-nix.nixosModules.sops
      #     ./hosts/nixcloud/configuration.nix
      #   ];
      # };
    };
}
