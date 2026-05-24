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
  # Home Manager configuration for NixOS systems
  flake.modules.nixos.home-manager = { inherit home-manager; };
}
