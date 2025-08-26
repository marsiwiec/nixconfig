{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    emacs.enable = lib.mkEnableOption "enable emacs editor";
  };
  config = lib.mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.mu4e
      ];
    };
    home.packages = with pkgs; [
      gnumake
      coreutils
      clang
      ripgrep
      fd
      pandoc
      shellcheck
      ispell
      cmake
      libtool
      nodejs
      sqlite

      isync
      pinentry-curses

      imagemagick
      maim
      graphviz
    ];
    services.emacs.enable = true;
    programs.zsh.initContent = ''
      export PATH="$HOME/.emacs.d/bin:$PATH"
    '';
    programs = {
      mu.enable = true;
      msmtp = {
        enable = true;
      };
      password-store.enable = true;
    };
  };
}
