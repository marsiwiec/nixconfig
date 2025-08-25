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
    home.packages = with pkgs; [
      emacs
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
    ];
    services.emacs.enable = true;
    programs.zsh.initContent = ''
      export PATH="$HOME/.emacs.d/bin:$PATH"
    '';
  };
}
