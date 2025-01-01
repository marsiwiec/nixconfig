{ lib, ... }:
{
  imports = [
    ./media.nix
    ./spicetify.nix
  ];
  media.enable = lib.mkDefault true;
  spicetify.enable = lib.mkDefault true;
}
