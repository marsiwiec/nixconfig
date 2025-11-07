{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
    ./niri
    ./mako.nix
    ./waybar.nix
    ./noctalia.nix
    ./hypridle.nix
    ./swayidle.nix
  ];
  niri.enable = lib.mkDefault true;
  # hyprland.enable = lib.mkDefault true;
  # plasma-manager.enable = lib.mkDefault true;
  # waybar.enable = lib.mkDefault true;
  noctalia.enable = lib.mkDefault true;
  # hypridle.enable = lib.mkDefault true;
  swayidle.enable = lib.mkDefault true;
}
