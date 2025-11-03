{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    python.enable = lib.mkEnableOption "python config";
  };
  config = lib.mkIf config.python.enable {
    environment.systemPackages = with pkgs; [
      uv
    ];
  };
}
