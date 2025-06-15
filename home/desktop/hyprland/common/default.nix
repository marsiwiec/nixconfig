{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
  ];

  hyprland.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
}
