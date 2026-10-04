{
  flake.modules.nixos.networking = {
    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [ 25565 ]; # minecraft server
      };
      networkmanager.enable = true;
      # useDHCP = true;
    };
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
