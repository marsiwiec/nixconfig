{ lib, ... }:
{
  imports = [
    ./browsers
    ./cloud
    ./editors
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
