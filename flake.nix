{

  description = "My nixos flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    stylix.url = "github:danth/stylix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      stylix,
      plasma-manager,
      spicetify-nix,
      ...
    }:
    let
      username = "msiwiec";
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        ### Home desktop ###
        nixgroot = lib.nixosSystem {
          inherit system;
          specialArgs = {
            username = "${username}";
            inherit inputs;
          };
          modules = [
            stylix.nixosModules.stylix
            ./systems/nixgroot/configuration.nix
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
        "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            inputs.plasma-manager.homeManagerModules.plasma-manager
            stylix.homeManagerModules.stylix
            inputs.spicetify-nix.homeManagerModules.default
            ./home/home.nix
            {
              home = {
                username = "${username}";
                homeDirectory = "/home/${username}";
              };
            }
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };

    };
}
