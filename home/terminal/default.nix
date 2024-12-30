{lib, ...}: {
  imports = [
    ./kitty.nix
    ./sh.nix
    ./utils.nix
  ];
  kitty.enable = lib.mkDefault true;
  sh.enable = lib.mkDefault true;
  terminal-utils.enable = lib.mkDefault true;
}
