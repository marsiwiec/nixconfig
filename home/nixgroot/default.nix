{ lib, ... }:
{
  imports = [
    ./looking-glass.nix
  ];
  looking-glass.enable = lib.mkDefault true;
}
