{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    logitech.enable = lib.mkEnableOption "configure logitech mouse";
  };

  config = lib.mkIf config.logitech.enable {
    # hardware.logitech.wireless.enable = true;

    services.ratbagd.enable = true;

    environment.systemPackages = with pkgs; [
      piper
    ];
  };
}
