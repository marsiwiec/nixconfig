{
  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #    plasma-manager = {
    #      url = "github:nix-community/plasma-manager";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #      inputs.home-manager.follows = "home-manager";
    #    };

    hyprland.url = "github:hyprwm/Hyprland";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-stable,
    ghostty,
    home-manager,
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
          ./systems/nixgroot/configuration.nix
          {
            environment.systemPackages = [
              ghostty.packages.${system}.default
            ];
          }
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
          ./systems/labnix/configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "${username}@nixgroot" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          # inputs.plasma-manager.homeManagerModules.plasma-manager
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
          inputs.spicetify-nix.homeManagerModules.default
          ./systems/nixgroot/home.nix
          ./homeManagerModules
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
          stylix.homeManagerModules.stylix
          nixvim.homeManagerModules.nixvim
          inputs.spicetify-nix.homeManagerModules.default
          ./systems/labnix/home.nix
          ./homeManagerModules
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
