{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    #./R.nix
    ./python.nix
    ./stylix.nix
    ./utils.nix
    ./virtualisation.nix
    ./avahi.nix
    ./tailscale.nix
    ./inputleap.nix
    ./gc.nix
    ./hyprland.nix
  ];
}
