{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
  ];
  plasma6.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault true;
}
