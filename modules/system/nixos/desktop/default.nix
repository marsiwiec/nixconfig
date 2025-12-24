{ lib, ... }:
{
  imports = [
    ./hyprland
    ./KDE
    ./niri
    ./niri/dank-material-shell.nix
  ];
  plasma6.enable = lib.mkDefault false;
  # hyprland.enable = lib.mkDefault true;
  niri.enable = lib.mkDefault true;
  dankMaterialShell.enable = lib.mkDefault true;
}
