{
  description = "My nixos flake";

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

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };

    niri.url = "github:sodiboo/niri-flake";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix = {
      url = "github:nix-community/stylix/3eb00bf9866634bd83219dd02d1ee0144b6f673e";
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
        nixgroot = mkNixOSConfig ./machines/nixgroot/configuration.nix;
        labnix = mkNixOSConfig ./machines/labnix/configuration.nix;
      };
    };
}
