{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    maestral.enable = lib.mkEnableOption "enable maestral dropbox client";
  };
  config = lib.mkIf config.maestral.enable {
    home.packages = with pkgs; [
      maestral
    ];
  };
}
