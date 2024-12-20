{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    pciutils
    wget
    fastfetch
    ripgrep
    kitty
    tree
    fzf
  ];
  programs = {
    bat.enable = true;
    yazi.enable = true;
    htop.enable = true;
    git.enable = true;
  };
}
