{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
    ./niri
    ./mako.nix
    ./waybar.nix
  ];
  niri.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
}
