{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    super-productivity.enable = lib.mkEnableOption "enable super-productivity note app";
  };
  config = lib.mkIf config.super-productivity.enable {
    home.packages = with pkgs; [
      super-productivity
    ];
  };
}
