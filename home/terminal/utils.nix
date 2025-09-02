{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    terminal-utils.enable = lib.mkEnableOption "enable additional utils for terminal";
  };
  config = lib.mkIf config.terminal-utils.enable {
    programs.fd.enable = true;
    home.packages = with pkgs; [
      unzip
      duf
      just
    ];
  };
}
