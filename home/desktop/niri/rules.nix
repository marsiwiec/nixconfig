{ ... }:
{
  programs.niri = {
    settings = {
      window-rules = [
        {
          draw-border-with-background = false;
          clip-to-geometry = true;
          geometry-corner-radius =
            let
              r = 8.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
        }
        {
          matches = [
            {
              app-id = "org.wezfurlong.wezterm";
            }
          ];
          default-column-width.fixed = 1110;
        }
        {
          matches = [
            {
              app-id = "^firefox$";
              title = "^Picture-in-Picture$";
            }
          ];
          open-floating = true;
          default-floating-position = {
            x = 8;
            y = 8;
            relative-to = "bottom-right";
          };
        }
        {
          matches = [
            {
              app-id = "^spotify$";
            }
          ];
          # open-on-workspace = "music";
          open-maximized = true;
        }
      ];
      layer-rules = [
        {
          matches = [
            {
              namespace = "^hyprpaper$";
            }
          ];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
