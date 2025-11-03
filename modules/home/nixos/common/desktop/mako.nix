{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    mako.enable = lib.mkEnableOption "enable mako notification daemon";
  };

  config = lib.mkIf config.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        default-timeout = 12000;
      };
    };
  };
}
