{ lib, ... }:
{
  imports = [
    ./obsidian.nix
    ./super-productivity.nix
    ./zotero.nix
  ];
  obsidian.enable = lib.mkDefault true;
  super-productivity.enable = lib.mkDefault true;
  zotero.enable = lib.mkDefault true;
}
