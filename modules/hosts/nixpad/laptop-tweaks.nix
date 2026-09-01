{
  flake.modules.nixos.nixpad-laptop =
    { pkgs, ... }:
    {
      # ThinkPad-specific extras: fan control, battery and hotkeys via thinkpad_acpi
      boot.kernelModules = [ "thinkpad_acpi" ];

      # Power/efficiency tweaks for the AMD Ryzen PRO (Rembrandt) APU
      services.power-profiles-daemon.enable = true;

      # Sensor monitoring tools useful for laptop tuning
      environment.systemPackages = with pkgs; [ lm_sensors ];

      # Upower is needed by noctalia's battery widget
      services.upower.enable = true;

      # Trackpoint support (ThinkPad nub)
      hardware.trackpoint = {
        enable = true;
        emulateWheel = true;
      };

      # Fingerprint reader (present on most T14 Gen3 SKUs; harmless if absent)
      services.fprintd.enable = true;

      # Suspend-friendly: niri + noctalia handle lock; enable hibernate via swap
      services.logind.settings.Login.HandlePowerKey = "suspend";
    };
}
