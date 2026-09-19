{
  flake.modules.homeManager.foot =
    { ... }:
    {
      programs.foot = {
        enable = true;
        server.enable = true;
        settings = {
          main.pad = "4x0";
          cursor = {
            style = "beam";
            blink = "no";
          };
        };
      };
    };
}
