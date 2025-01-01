{ lib, ... }:
{
  imports = [
    ./maestral.nix
    ./rclone.nix
  ];
  maestral.enable = lib.mkDefault true;
  rclone.enable = lib.mkDefault true;
}
