{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
    ./niri
    ./mako.nix
    ./waybar.nix
    ./hypridle.nix
  ];
  niri.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  plasma-manager.enable = lib.mkDefault false;
  waybar.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
}
