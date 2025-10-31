{
  pkgs,
  vars,
  inputs,
  ...
}:
{
  imports = [
    # ./browsers
    # ./cloud
    # ./editors
    # ./graphics
    # ./media
    # ./office
    # ./terminal
  ];

  home = {
    username = vars.userName;
    homeDirectory = "/Users/${vars.userName}";
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;

}
