{pkgs, ...}: {
  home.packages = with pkgs; [
    maestral
  ];
}
