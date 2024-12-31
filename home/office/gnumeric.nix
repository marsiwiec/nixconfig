{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    gnumeric.enable = lib.mkEnableOption "enable gnumeric spreadsheet app";
  };
  config = lib.mkIf config.gnumeric.enable {
    home.packages = with pkgs; [
      gnumeric
    ];
  };
}
