{
  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.11";

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

    helix.url = "github:helix-editor/helix/master";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix.url = "github:danth/stylix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      sops-nix,
      disko,
      home-manager,
      plasma-manager,
      stylix,
      spicetify-nix,
      ...
    }@inputs:
    let
      username = "msiwiec";
    in
    {
      nixosConfigurations = {

        ### Home desktop ###
        nixgroot = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "${username}";
            inherit inputs;
          };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            ./hosts/nixgroot/configuration.nix
            stylix.nixosModules.stylix
            sops-nix.nixosModules.sops
            ./style/stylix/system/nixgroot
          ];
        };

        ### Lab desktop ###
        labnix = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "${username}";
            inherit inputs;
          };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            stylix.nixosModules.stylix
            sops-nix.nixosModules.sops
            ./hosts/labnix/configuration.nix
            ./style/stylix/system/labnix
          ];
        };

        ### Hetzner Cloud ###
        nixcloud = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./hosts/nixcloud/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "${username}@nixgroot" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            inputs.plasma-manager.homeManagerModules.plasma-manager
            stylix.homeManagerModules.stylix
            inputs.spicetify-nix.homeManagerModules.default
            ./home.nix
            ./style/stylix/home/nixgroot
            ./home/desktop/hyprland/nixgroot
            {
              home = {
                username = "${username}";
                homeDirectory = "/home/${username}";
              };
            }
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        "${username}@labnix" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            inputs.plasma-manager.homeManagerModules.plasma-manager
            stylix.homeManagerModules.stylix
            inputs.spicetify-nix.homeManagerModules.default
            ./home.nix
            ./home/desktop/hyprland/labnix
            ./style/stylix/home/labnix
            {
              home = {
                username = "${username}";
                homeDirectory = "/home/${username}";
              };
            }
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
