{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./plasma6.nix
  ];
  plasma6.enable = lib.mkDefault false;
  hyprland.enable = lib.mkDefault true;
}
