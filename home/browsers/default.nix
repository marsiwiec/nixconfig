{ lib, ... }:
{
  imports = [
    ./qutebrowser.nix
    ./chromium.nix
  ];
  qutebrowser.enable = lib.mkDefault true;
  chromium.enable = lib.mkDefault true;
}
