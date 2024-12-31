{lib, ...}: {
  imports = [
    ./direnv.nix
  ];
  direnv.enable = lib.mkDefault true;
}
