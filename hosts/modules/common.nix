{ pkgs, ... }:
{
  imports = [
    ./firefox.nix
    #./R.nix
    ./python.nix
    ./stylix.nix
    ./utils.nix
    ./virtualisation.nix
  ];
}
