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

    niri.url = "github:sodiboo/niri-flake";

    helix.url = "github:helix-editor/helix/master";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix.url = "github:danth/stylix/79e816c2e63df5024e28292fee0d92dc106ff66c";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      silentSDDM,
      sops-nix,
      disko,
      home-manager,
      niri,
      plasma-manager,
      stylix,
      spicetify-nix,
      ...
    }@inputs:
    let
      username = "msiwiec";
      common-nixos-modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./overlays
        stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
        niri.nixosModules.niri
      ];
      common-home-modules = [
        inputs.plasma-manager.homeManagerModules.plasma-manager
        stylix.homeManagerModules.stylix
        inputs.spicetify-nix.homeManagerModules.default
        niri.homeModules.niri
        niri.homeModules.stylix
        ./home.nix
        {
          home = {
            username = "${username}";
            homeDirectory = "/home/${username}";
          };
        }
      ];
    in
    {
      nixosConfigurations = {

        ### Home desktop ###
        nixgroot = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "${username}";
            inherit inputs;
          };
          modules = common-nixos-modules ++ [
            ./hosts/nixgroot/configuration.nix
            ./style/stylix/system/nixgroot
          ];
        };

        ### Lab desktop ###
        labnix = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            username = "${username}";
            inherit inputs;
          };
          modules = common-nixos-modules ++ [
            ./hosts/labnix/configuration.nix
            ./style/stylix/system/labnix
          ];
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

      homeConfigurations = {
        "${username}@nixgroot" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = common-home-modules ++ [
            ./style/stylix/home/nixgroot
            ./home/desktop/hyprland/nixgroot
            ./home/desktop/niri/nixgroot.nix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
        "${username}@labnix" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = common-home-modules ++ [
            ./style/stylix/home/labnix
            ./home/desktop/hyprland/labnix
          ];
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      };
    };
}
