{ lib, ... }:
{
  imports = [
    ./helix.nix
  ];
  helix.enable = lib.mkDefault true;

}
