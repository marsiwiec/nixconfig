{
  flake.modules.nixos.power =
    { config, ... }:
    {
      # Use the modern AMD CPPC frequency scaling driver.
      # "active" gives the kernel scheduler direct control and exposes EPP profiles.
      boot.kernelParams = [ "amd_pstate=active" ];

      environment.systemPackages = [ config.boot.kernelPackages.cpupower ];
    };
}
