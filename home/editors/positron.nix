{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    positron.enable = lib.mkEnableOption "positron IDE";
  };
  config = lib.mkIf config.positron.enable {
    home.packages = with pkgs; [
      positron-bin
    ];
  };
}
