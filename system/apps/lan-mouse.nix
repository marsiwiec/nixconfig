{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    lan-mouse.enable = lib.mkEnableOption "lan-mouse config for sharing mouse/keyboard";
  };
  config = lib.mkIf config.lan-mouse.enable {
    environment.systemPackages = with pkgs; [
      lan-mouse
    ];
    networking.firewall.allowedTCPPorts = [ 4242 ];
  };
}
