{
  description = "My nixos/darwin flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

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

    mac-app-util.url = "github:hraban/mac-app-util";

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    niri.url = "github:sodiboo/niri-flake";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-cli = {
      url = "github:AvengeMedia/danklinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
    };

    stylix = {
      url = "github:nix-community/stylix";
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

      mkNixOSConfig =
        path:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs vars; };
          modules = [
            inputs.stylix.nixosModules.stylix
            ./style/stylix/nixos.nix
            path
          ];
        };

      mkDarwinConfig =
        path:
        nix-darwin.lib.darwinSystem {
          specialArgs = { inherit inputs outputs vars; };
          modules = [
            inputs.home-manager.darwinModules.home-manager
            inputs.stylix.darwinModules.stylix
            inputs.mac-app-util.darwinModules.default
            path
          ];
        };
    in
    {
      nixosConfigurations = {
        ### Home desktop ###
        nixgroot = mkNixOSConfig ./machines/nixgroot/configuration.nix;
        labnix = mkNixOSConfig ./machines/labnix/configuration.nix;
      };
      darwinConfigurations = {
        macnix = mkDarwinConfig ./machines/macnix/configuration.nix;
      };
    };
}
