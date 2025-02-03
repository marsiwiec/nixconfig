{
  lib,
  config,
  ...
}:
{
  options = {
    alacritty.enable = lib.mkEnableOption "enable alacritty terminal";
  };
  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 5;
            y = 0;
          };
        };
        cursor = {
          style = {
            shape = "Beam";
          };
        };
      };
    };
  };
}
