{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    #./R.nix
    ./python.nix
    ./utils.nix
    ./virtualisation.nix
    ./avahi.nix
    ./tailscale.nix
    ./inputleap.nix
    ./gc.nix
    ./hyprland.nix
    ./nvidia-enable.nix
    ./plasma6.nix
    ../../stylix/stylix.nix
    ./thunar.nix
  ];
}
