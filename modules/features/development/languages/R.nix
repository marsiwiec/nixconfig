{ inputs, ... }:
{
  flake.modules.nixos.R = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.R
    ];
    nixpkgs.config.permittedInsecurePackages = [
      "electron-38.8.4"
    ];
  };

  flake.modules.homeManager.R =
    { pkgs, ... }:
    {
      home.packages =
        with pkgs;
        let
          RStudio-with-my-packages = rstudioWrapper.override {
            # nodejs-slim = pkgs.nodejs // {
            #   python = pkgs.nodejs-slim.python;
            # };
            packages = with rPackages; [
              tidyverse
              patchwork
              drc
              rstatix
              ggthemes
              styler
              rsvg
            ];
          };
        in
        [
          RStudio-with-my-packages
          quarto
        ];
    };
}
