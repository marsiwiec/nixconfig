{ lib, ... }:
{
  imports = [
    ./qutebrowser.nix
    ./chromium.nix
  ];
  qutebrowser.enable = lib.mkDefault false;
  chromium.enable = lib.mkDefault true;
}
