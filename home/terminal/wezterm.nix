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
      extraConfig = ''
        return {
          enable_tab_bar = false,
          default_cursor_style = "SteadyBar",
          window_close_confirmation = "NeverPrompt",
        }
      '';
    };
  };
}
