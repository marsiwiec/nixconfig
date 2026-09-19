{
  flake.modules.homeManager.foot =
    { ... }:
    {
      programs.foot = {
        enable = true;
        server.enable = true;
        settings.cursor = {
          style = "beam";
          blink = "no";
        };
      };
    };
}
