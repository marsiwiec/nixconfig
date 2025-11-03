{ lib, ... }:
{
  imports = [
    ./gnumeric.nix
    ./libre-office.nix
    ./zathura.nix
  ];
  # gnumeric.enable = lib.mkDefault true;
  libreoffice.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
}
