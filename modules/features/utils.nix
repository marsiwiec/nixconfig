{
  flake.modules.nixos.utils =
    { pkgs, ... }:
    {
      environment.localBinInPath = true;
      environment.systemPackages = with pkgs; [
        neovim
        pciutils
        wget
        fastfetch
        ripgrep
        tree
        fzf
        dysk
        inotify-tools
        gparted
      ];
    };
}
