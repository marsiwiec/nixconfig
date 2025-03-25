{ lib, ... }:
{
  imports = [
    ./emacs.nix
    ./helix.nix
    ./positron.nix
    ./rstudio.nix
  ];
  # emacs.enable = lib.mkDefault true;
  helix.enable = lib.mkDefault true;
  positron.enable = lib.mkDefault true;
  rstudio.enable = lib.mkDefault true;

}
