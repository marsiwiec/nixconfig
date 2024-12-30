{
  lib,
  config,
  ...
}: {
  options = {
    polkit.enable = lib.mkEnableOption "polkit for wms";
  };
  config = lib.mkIf config.polkit.enable {
    security.polkit.enable = true;
  };
}
