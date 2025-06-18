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
        # {
        #   matches = [
        #     {
        #       title = "^Steam$";
        #     }
        #   ];
        #   open-on-workspace = "games";
        # }
        # {
        #   matches = [
        #     {
        #       app-id = "^looking-glass-client$";
        #     }
        #   ];
        #   open-on-workspace = "win";
        # }
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
