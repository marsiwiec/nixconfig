{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    firefox.enable = lib.mkEnableOption "enable firefox";
  };
  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          path = "default";
        };
      };
    };
  };
}
