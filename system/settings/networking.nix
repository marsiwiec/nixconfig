{
  lib,
  config,
  ...
}:
{
  options = {
    networking.enable = lib.mkEnableOption "networking config";
  };
  config = lib.mkIf config.networking.enable {
    networking = {
      firewall.enable = true;
      networkmanager.enable = true;
    };
    services = {
      openssh.enable = true;
    };
  };
}
