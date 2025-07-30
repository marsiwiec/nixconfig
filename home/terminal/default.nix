{ lib, ... }:
{
  imports = [
    ./shells
    ./emulators
    ./utils.nix
    ./git.nix
  ];
  wezterm.enable = lib.mkDefault true;
  shell-common.enable = lib.mkDefault true;
  terminal-utils.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
}
