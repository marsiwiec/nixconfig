{ lib, ... }:
{
  imports = [
    ./fonts.nix
  ];

  sysfonts.enable = lib.mkDefault true;
}
