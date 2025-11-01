{
  pkgs,
  vars,
  inputs,
  ...
}:
{
  imports = [
    inputs.mac-app-util.homeManagerModules.default
    ./browsers
    # ./cloud
    ./editors
    # ./graphics
    # ./media
    ./office
    ./terminal
  ];
  positron.enable = false;
  emacs.enable = false;
  chromium.enable = false;
  zathura.enable = false;
  libreoffice.enable = false;

  stylix.targets = {
    firefox = {
      firefoxGnomeTheme.enable = true;
      profileNames = [ "default" ];
    };
  };

  home = {
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

}
