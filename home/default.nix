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
    ./terminal
    ./desktop
    ../style/stylix
    ../style/stylix/home
  ];
}
