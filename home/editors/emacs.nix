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

      pinentry-curses

      imagemagick
      maim
      graphviz
    ];
    services = {
      emacs.enable = true;
      mbsync = {
        enable = true;
        postExec = "${pkgs.mu}/bin/mu index";
      };
    };
    programs.zsh.initContent = ''
      export PATH="$HOME/.emacs.d/bin:$PATH"
    '';
    programs = {
      mu.enable = true;
      msmtp.enable = true;
      password-store.enable = true;
    };
  };
}
