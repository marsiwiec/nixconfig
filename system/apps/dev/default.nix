{ lib, ... }:
{
  imports = [
    ./devenv.nix
    ./R.nix
    ./python.nix
    ./LSPs.nix
  ];

  devenv.enable = lib.mkDefault true;
  #  R.enable = lib.mkDefault true;
  python.enable = lib.mkDefault true;
  LSPs.enable = lib.mkDefault true;
}
