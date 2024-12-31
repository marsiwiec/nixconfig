{ lib, ... }:
{
  imports = [
    ./R.nix
    ./python.nix
  ];
  R.enable = lib.mkDefault false;
  python.enable = lib.mkDefault true;
}
