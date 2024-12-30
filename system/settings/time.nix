{
  lib,
  config,
  ...
}: {
  options = {
    time.enable = lib.mkEnableOption "time sync settings";
  };

  config = lib.mkIf config.time.enable {
    time.timeZone = "Europe/Warsaw";
    services.timesyncd.enable = true;
  };
}
