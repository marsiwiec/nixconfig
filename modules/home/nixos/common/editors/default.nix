{ lib, ... }:
{
  imports = [
    ./emacs
    ./positron.nix
  ];
  # emacs.enable = lib.mkDefault true;
  positron.enable = lib.mkDefault true;
}
