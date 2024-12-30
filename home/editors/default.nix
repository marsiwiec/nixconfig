{lib, ...}: {
  imports = [
    ./emacs.nix
    ./helix.nix
    ./nixvim.nix
  ];
  emacs.enable = lib.mkDefault true;
  helix.enable = lib.mkDefault true;
  nixvim.enable = lib.mkDefault true;
}
