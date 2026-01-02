{
  pkgs,
  vars,
  inputs,
  ...
}:
{
  imports = [
    inputs.mac-app-util.homeManagerModules.default
    ../common
  ];

  super-productivity.enable = false;

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
