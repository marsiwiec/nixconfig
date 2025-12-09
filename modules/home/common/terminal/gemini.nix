{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    gemini.enable = lib.mkEnableOption "enable gemini-cli";
  };
  config = lib.mkIf config.gemini.enable {
    home.packages = with pkgs; [
      gemini-cli-bin
    ];
  };
}
