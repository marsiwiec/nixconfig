{ lib, ... }:
{
  imports = [
    ./plasma-manager.nix
  ];
  plasma-manager.enable = lib.mkDefault false;
}
