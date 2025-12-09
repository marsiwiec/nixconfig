{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    claude.enable = lib.mkEnableOption "enable claude-code";
  };
  config = lib.mkIf config.claude.enable {
    home.packages = with pkgs; [
      claude-code
      claude-monitor
    ];
  };
}
