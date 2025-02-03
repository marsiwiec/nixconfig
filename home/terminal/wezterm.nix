{
  lib,
  config,
  ...
}:
{
  options = {
    wezterm.enable = lib.mkEnableOption "enable wezterm terminal";
  };
  config = lib.mkIf config.wezterm.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
