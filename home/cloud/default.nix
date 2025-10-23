{ lib, ... }:
{
  imports = [
    ./maestral.nix
    ./rclone.nix
    ./syncthing.nix
  ];
  # maestral.enable = lib.mkDefault true;
  rclone.enable = lib.mkDefault true;
  syncthing.enable = lib.mkDefault true;
}
