{ lib, ... }:
{
  imports = [
    ./firefox.nix
    ./qutebrowser.nix
  ];
  firefox.enable = lib.mkDefault true;
  qutebrowser.enable = lib.mkDefault false;
}
