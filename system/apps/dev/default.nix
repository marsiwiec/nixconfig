{ lib, ... }:
{
  imports = [
    ./R.nix
    ./python.nix
    ./LSPs.nix
  ];
  R.enable = lib.mkDefault true;
  python.enable = lib.mkDefault true;
  LSPs.enable = lib.mkDefault true;
}
