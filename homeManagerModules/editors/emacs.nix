{pkgs, ...}: {
  home.packages = with pkgs; [
    emacs
    coreutils
    ripgrep
    fd
  ];
  services.emacs.enable = true;
}
