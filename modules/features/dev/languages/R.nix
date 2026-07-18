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
        let
          RStudio-with-my-packages = pkgs.unstable.rstudioWrapper.override {
            packages = with pkgs.rPackages; [
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
          pkgs.quarto
        ];
    };
}
