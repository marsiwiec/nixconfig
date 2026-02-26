{ ... }:
let
  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    backupCommand = "rm";
    overwriteBackup = true;
  };
in
{
  # Home Manager configurations for NixOS and Darwin systems
  flake.modules.nixos.home-manager = { inherit home-manager; };

  flake.modules.darwin.home-manager = { inherit home-manager; };
}
