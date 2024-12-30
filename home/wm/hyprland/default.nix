{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./hypridle.nix
  ];
  hyprland.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;
}
