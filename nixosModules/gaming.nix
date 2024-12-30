{
  config,
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  programs = {
    steam.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
  };

  environment.systemPackages = [
    pkgs-stable.heroic
  ];
}
