{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    emacs.enable = lib.mkEnableOption "enable emacs editor";
  };
  config = lib.mkIf config.emacs.enable {
    home.packages = with pkgs; [
      emacs
      coreutils
      ripgrep
      fd
    ];
    services.emacs.enable = true;
  };
}
