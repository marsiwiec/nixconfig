{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    rstudio.enable = lib.mkEnableOption "RStudio IDE";
  };
  config = lib.mkIf config.rstudio.enable {
    home.packages = [ pkgs.rstudio ];
  };
}
