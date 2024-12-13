{

  description = "My nixvm flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixvm = lib.nixosSystem {
          inherit system;
          modules = [
            stylix.nixosModules.stylix
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        msiwiec = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            stylix.homeManagerModules.stylix
            ./home.nix
          ];
        };
      };

    };
}
