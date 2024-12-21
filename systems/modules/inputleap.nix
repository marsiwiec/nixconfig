{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    input-leap
  ];
  networking.firewall.allowedTCPPorts = [ 24800 ];
}
