{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    pciutils
    wget
    git
    fastfetch
    yazi
    ripgrep
    fzf
    bat
    htop
    kitty
  ];
}