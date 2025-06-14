{ lib, ... }:
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./waybar.nix
  ];

  hyprland.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
}
