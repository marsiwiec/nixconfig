{ inputs, ... }:
{
  flake.modules = {
    nixos.utils =
      { pkgs, ... }:
      {
        home-manager.sharedModules = [
          inputs.self.modules.homeManager.utils
        ];
        environment.localBinInPath = true;
        environment.systemPackages = with pkgs; [
          neovim
          pciutils
          wget
          fastfetch
          ripgrep
          tree
          dysk
          inotify-tools
          gparted
        ];
      };
    homeManager.utils = {
      programs = {
        jq.enable = true;
        fzf.enable = true;
      };
    };
  };
}
