{pkgs, ...}: {
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    xwaylandvideobridge
    elisa
  ];
}
