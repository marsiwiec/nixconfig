{
  flake.modules.nixos.boot =
    { pkgs, ... }:
    {
      boot = {
        tmp = {
          useTmpfs = true;
          cleanOnBoot = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          systemd-boot = {
            enable = true;
            configurationLimit = 20;
          };
          efi.canTouchEfiVariables = true;
        };
        plymouth.enable = true;
        consoleLogLevel = 0;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "loglevel=3"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "udev.log_priority=3"
          "amdgpu.dcdebugmask=0x10"
        ];
      };

    };
}
