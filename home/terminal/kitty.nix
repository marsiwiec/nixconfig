{
  lib,
  config,
  ...
}:
{
  options = {
    kitty.enable = lib.mkEnableOption "enable kitty terminal";
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        wayland_titlebar_color = "background";
        window_padding_width = 5;
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
    };
  };
}
