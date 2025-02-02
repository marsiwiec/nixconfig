{ lib, ... }:
{
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./sh.nix
    ./utils.nix
    ./git.nix
    ./foot.nix
  ];
  kitty.enable = lib.mkDefault true;
  foot_term.enable = lib.mkDefault true;
  sh.enable = lib.mkDefault true;
  terminal-utils.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  # ghostty.enable = lib.mkDefault true;
}
