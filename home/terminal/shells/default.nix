{ lib, ... }:
{
  imports = [
    ./common.nix
    ./nushell.nix
    ./zsh.nix
  ];

  shell-common.enable = lib.mkDefault true;
  nushell.enable = lib.mkDefault true;
  zsh-shell.enable = lib.mkDefault true;
}
