{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gvfs
  ];
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
