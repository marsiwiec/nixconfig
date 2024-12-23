{pkgs, ...}: {
  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    pciutils
    wget
    fastfetch
    ripgrep
    kitty
    tree
    fzf
    dysk
    inotify-tools
    nixd
    lua-language-server
    gparted
    nil
    gvfs
  ];
  programs = {
    bat.enable = true;
    yazi.enable = true;
    htop.enable = true;
    git.enable = true;
  };
}
