{pkgs, ...}: {
  home.packages = with pkgs; [
    gnumeric
  ];
}
