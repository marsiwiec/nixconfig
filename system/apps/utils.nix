{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    utils.enable = lib.mkEnableOption "additional system utils";
  };

  config = lib.mkIf config.utils.enable {
    environment.localBinInPath = true;
    environment.systemPackages = with pkgs; [
      vim
      pciutils
      wget
      fastfetch
      ripgrep
      kitty
      tree
      fzf
      dysk
      inotify-tools
      gparted
      gvfs
    ];
    programs = {
      bat.enable = true;
      yazi.enable = true;
      htop.enable = true;
      git.enable = true;
    };
  };
}
