{ lib, ... }:
{
  imports = [
    ./vfio.nix
    ./audio.nix
    ./nvidia.nix
    ./graphics.nix
    ./printing.nix
    ./bluetooth.nix
    ./nvidia-enable.nix
  ];
  vfio.enable = lib.mkDefault true;
  audio.enable = lib.mkDefault true;
  nvidia.enable = lib.mkDefault true;
  graphics.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  bluetooth.enable = lib.mkDefault true;
  nvidia-enable.enable = lib.mkDefault true;
}
