{pkgs, ...}: {
  programs.fd.enable = true;
  home.packages = with pkgs; [
    unzip
  ];
}
