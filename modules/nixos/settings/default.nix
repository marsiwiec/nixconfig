{ lib, ... }:
{
  imports = [
    ./gc.nix
    ./sddm.nix
    ./time.nix
    ./power.nix
    ./users.nix
    ./greetd.nix
    ./boot.nix
    ./locale.nix
    ./nix-ld.nix
    ./polkit.nix
    ./shells.nix
    ./nixpkgs.nix
    ./networking.nix
    ./filesystems.nix
    ./virtualisation.nix
  ];
  sddm.enable = lib.mkDefault true;
  greetd.enable = lib.mkDefault false;

  gc.enable = lib.mkDefault true;
  time.enable = lib.mkDefault true;
  power.enable = lib.mkDefault true;
  users.enable = lib.mkDefault true;
  boot.enable = lib.mkDefault true;
  locale.enable = lib.mkDefault true;
  nixld.enable = lib.mkDefault true;
  polkit.enable = lib.mkDefault true;
  shells.enable = lib.mkDefault true;
  nixpkgs.enable = lib.mkDefault true;
  networking.enable = lib.mkDefault true;
  filesystems.enable = lib.mkDefault true;
  virtualization.enable = lib.mkDefault true;
}
