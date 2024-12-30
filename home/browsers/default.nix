{lib, ...}: {
  imports = [
    ./qutebrowser.nix
  ];
  qutebrowser.enable = lib.mkDefault true;
}
