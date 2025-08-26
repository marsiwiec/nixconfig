{ lib, ... }:
{
  imports = [
    ./gnumeric.nix
    ./libre-office.nix
    ./obsidian.nix
    ./zathura.nix
    ./zotero.nix
  ];
  # gnumeric.enable = lib.mkDefault true;
  libreoffice.enable = lib.mkDefault true;
  obsidian.enable = lib.mkDefault true;
  zathura.enable = lib.mkDefault true;
  zotero.enable = lib.mkDefault true;
}
