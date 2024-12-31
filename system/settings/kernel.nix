{
  lib,
  pkgs,
  ...
}:
{
  options = {
    kernel.enable = lib.mkEnableOption "kernel config";
  };
  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      plymouth = {
        enable = true;
        theme = lib.mkForce "infinite_seal";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [ "infinite_seal" ];
          })
        ];
      };
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
      ];
    };
  };
}
