{ lib, ... }:
{
  imports = [
    ./firefox.nix
    ./qutebrowser.nix
    ./chromium.nix
  ];
  firefox.enable = lib.mkDefault true;
  qutebrowser.enable = lib.mkDefault false;
  # chromium.enable = lib.mkDefault true;
}
