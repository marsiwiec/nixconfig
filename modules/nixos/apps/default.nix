{ lib, ... }:
{
  imports = [
    ./dev
    ./utils.nix
    ./thunar.nix
    ./firefox.nix
    ./sunshine.nix
    ./distrobox.nix
    ./lan-mouse.nix
    ./nh.nix
    ./tailscale.nix
    ./ollama.nix
    ./bottles.nix
    ./localsend.nix
  ];

  lan-mouse.enable = lib.mkDefault false;

  nh.enable = lib.mkDefault true;
  utils.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  firefox.enable = lib.mkDefault true;
  sunshine.enable = lib.mkDefault true;
  distrobox.enable = lib.mkDefault true;
  tailscale.enable = lib.mkDefault true;
  ollama.enable = lib.mkDefault true;
  bottles.enable = lib.mkDefault true;
  localsend.enable = lib.mkDefault true;
}
