{pkgs, ...}: {
  programs = {
    steam.enable = true;
    gamescope.enable = true;
  };

  environment.systemPackages = with pkgs; [
    heroic
  ];
}
