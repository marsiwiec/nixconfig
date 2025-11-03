{
  config,
  lib,
  ...
}:
{
  options.foot_term.enable = lib.mkEnableOption "foot terminal emulator";
  config = lib.mkIf config.foot_term.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          pad = "5x0";
        };
        cursor = {
          style = "beam";
          blink = true;
        };
      };
    };
  };
}
