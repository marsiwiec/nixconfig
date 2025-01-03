{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    R.enable = lib.mkEnableOption "config for R programming with RStudio and sensible default package base";
  };

  config = lib.mkIf config.R.enable {
    environment.systemPackages =
      with pkgs;
      let
        RStudio-with-my-packages = rstudioWrapper.override {
          packages = with rPackages; [
            tidyverse
            patchwork
            drc
          ];
        };
      in
      [
        RStudio-with-my-packages
        quarto
      ];
  };
}
