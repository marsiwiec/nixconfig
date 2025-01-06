{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    sunshine.enable = lib.mkEnableOption "config for sunshine streaming";
  };
  config = lib.mkIf config.sunshine.enable {
    environment.systemPackages = with pkgs; [
      sunshine
    ];
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
