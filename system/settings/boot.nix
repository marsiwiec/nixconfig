{
  lib,
  pkgs,
  ...
}:
{
  options = {
    boot.enable = lib.mkEnableOption "boot config";
  };
  config = {
    boot = {
      # kernelPackages = pkgs.linuxPackages_latest;
      kernelPackages = pkgs.linuxPackages_6_12;
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
      plymouth = {
        enable = true;
        # theme = lib.mkForce "seal";
        # themePackages = with pkgs; [
        #   (adi1090x-plymouth-themes.override {
        #     selected_themes = [ "seal" ];
        #   })
        # ];
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
