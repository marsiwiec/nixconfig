{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    chromium.enable = lib.mkEnableOption "chromium config";
  };
  config = lib.mkIf config.chromium.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };
  };
}
