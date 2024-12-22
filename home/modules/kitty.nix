{ ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_size = "14";
      wayland_titlebar_color = "background";
      window_padding_width = 5;
    };
  };
}
