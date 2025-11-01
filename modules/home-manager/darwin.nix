{
  pkgs,
  vars,
  inputs,
  ...
}:
{
  imports = [
    inputs.mac-app-util.homeManagerModules.default
    # ./browsers
    # ./cloud
    ./editors
    # ./graphics
    # ./media
    # ./office
    ./terminal
  ];
  positron.enable = false;
  emacs.enable = false;

  home = {
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

}
