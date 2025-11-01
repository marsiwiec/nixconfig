{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
    ./niri
  ];
  plasma6.enable = lib.mkDefault false;
  # hyprland.enable = lib.mkDefault true;
  niri.enable = lib.mkDefault true;
}
