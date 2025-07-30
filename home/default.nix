{ lib, ... }:
{
  imports = [
    ./browsers
    ./cloud
    ./editors
    ./graphics
    ./media
    ./office
    ./terminal
    ./desktop
    ../style/stylix
    ../style/stylix/home
  ];
}
