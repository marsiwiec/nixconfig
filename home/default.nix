{ lib, ... }:
{
  imports = [
    ./browsers
    ./cloud
    ./editors
    ./graphics
    ./media
    ./nixos
    ./office
    ./passthrough
    ./terminal
    ./wm
    ../style/stylix
    ../style/stylix/home
  ];
}
