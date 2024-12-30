{
  lib,
  config,
  ...
}: {
  options = {
    power.enable = lib.mkEnableOption "powermgmt config";
  };
  config = lib.mkIf config.power.enable {
    powerManagement.enable = false;
  };
}
