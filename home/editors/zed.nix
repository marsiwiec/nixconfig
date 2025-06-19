{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    zed.enable = lib.mkEnableOption "zed editor";
  };
  config = lib.mkIf config.zed.enable {
    home.packages = with pkgs; [
      zed-editor-fhs
    ];
  };
}
