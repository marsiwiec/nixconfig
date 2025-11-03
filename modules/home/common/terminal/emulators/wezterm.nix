{
  lib,
  config,
  pkgs,
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
        local wezterm = require("wezterm")
        return {
          enable_tab_bar = false,
          default_cursor_style = "SteadyBar",
          window_close_confirmation = "NeverPrompt",
          window_decorations = ${if pkgs.stdenv.isDarwin then "RESIZE" else "NONE"},
          term = "wezterm",
          keys = {
            {
              key = "t",
              mods = "SUPER",
              action = wezterm.action.DisableDefaultAssignment,
            },
          },
        }
      '';
    };
  };
}
