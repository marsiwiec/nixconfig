{ lib, ... }:
{
  imports = [
    ./emacs.nix
    ./helix.nix
  ];
  # emacs.enable = lib.mkDefault true;
  helix.enable = lib.mkDefault true;
}
