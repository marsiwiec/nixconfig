{ lib, ... }:
{
  imports = [
    ./chromium.nix
  ];
  chromium.enable = lib.mkDefault true;
}
