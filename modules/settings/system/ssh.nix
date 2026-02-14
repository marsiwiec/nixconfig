{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
      };
    };
  };

  flake.modules.darwin.ssh = {
    services.openssh = {
      enable = true;
    };
  };
}
