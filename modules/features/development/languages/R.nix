{ inputs, ... }:
{
  flake.modules.nixos.R = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.R
    ];
  };

  flake.modules.homeManager.R =
    { pkgs, ... }:
    {
      home.packages =
        with pkgs;
        let
          RStudio-with-my-packages = rstudioWrapper.override {
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
