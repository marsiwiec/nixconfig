{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    let
      RStudio-with-my-packages = rstudioWrapper.override {
        packages = with rPackages; [
          tidyverse
          drc
          usethis
          devtools
          patchwork
        ];
      };
    in
    [
      RStudio-with-my-packages
    ];
}
