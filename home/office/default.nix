{ lib, ... }:
{
  imports = [
    ./gnumeric.nix
    ./libre-office.nix
    ./obsidian.nix
  ];
  gnumeric.enable = lib.mkDefault true;
  libreoffice.enable = lib.mkDefault true;
  obsidian.enable = lib.mkDefault true;
}
