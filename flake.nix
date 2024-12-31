{
  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    plasma-manager,
    nixvim,
    stylix,
    spicetify-nix,
    ...
  }: let
    username = "msiwiec";
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-stable = nixpkgs-stable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      ### Home desktop ###
      nixgroot = lib.nixosSystem {
        inherit system;
        specialArgs = {
          username = "${username}";
          inherit inputs;
          inherit pkgs-stable;
        };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/nixgroot/configuration.nix
        ];
      };

      ### Lab desktop ###
      labnix = lib.nixosSystem {
        inherit system;
        specialArgs = {
          username = "${username}";
          inherit inputs;
        };
        modules = [
          stylix.nixosModules.stylix
          ./hosts/labnix/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "${username}@nixgroot" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
          inputs.spicetify-nix.homeManagerModules.default
          ./home.nix
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
            };
          }
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-stable;
        };
      };
      "${username}@labnix" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
          inputs.spicetify-nix.homeManagerModules.default
          ./home.nix
          {
            home = {
              username = "${username}";
              homeDirectory = "/home/${username}";
            };
          }
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-stable;
        };
      };
    };
  };
}
