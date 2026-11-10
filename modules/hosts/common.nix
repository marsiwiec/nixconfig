{
  flake.modules.nixos.host-common =
    { ... }:
    {
      hardware.enableRedistributableFirmware = true;
      system.stateVersion = "26.05";

      services.fwupd.enable = true;

      # APC UPS monitoring and safety features
      services.apcupsd.enable = true;
    };
}
