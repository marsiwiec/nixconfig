{ lib, config, ... }:
{
  options = {
    chromium.enable = lib.mkEnableOption "chromium config";
  };
  config = lib.mkIf config.chromium.enable {
    programs.chromium = {
      enable = true;
    };
  };
}
