{ inputs, ... }:
{
  flake.modules.homeManager.default-settings = {
    imports = [
      inputs.home-manager.flakeModules.home-manager
    ];
    programs.home-manager.enable = true;

    home.sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
    };
  };
}
