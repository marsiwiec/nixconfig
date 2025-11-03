{
  lib,
  ...
}:
{
  imports = [
    ./dev
    ./tailscale.nix
  ];
  tailscale.enable = lib.mkDefault true;
}
