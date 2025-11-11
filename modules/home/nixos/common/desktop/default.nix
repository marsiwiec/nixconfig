{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
    ./niri
    ./mako.nix
    ./waybar.nix
    ./hypridle.nix
    ./swayidle.nix
    ./dank_material_shell.nix
  ];
  niri.enable = lib.mkDefault true;
  # hyprland.enable = lib.mkDefault true;
  # plasma-manager.enable = lib.mkDefault true;
  # waybar.enable = lib.mkDefault true;
  # hypridle.enable = lib.mkDefault true;
  swayidle.enable = lib.mkDefault true;
  dms.enable = lib.mkDefault true;
}
