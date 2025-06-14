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
    ./desktop
    ../style/stylix
    ../style/stylix/home
  ];
}
