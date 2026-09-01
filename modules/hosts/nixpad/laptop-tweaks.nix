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

      # Trackpoint support (ThinkPad nub). The udev rule matches on the exact
      # input device name — for this model "TPPS/2 Synaptics TrackPoint"
      # (see /proc/bus/input/devices), NOT the nixpkgs default "TPPS/2 IBM
      # TrackPoint", so without `device` the rule silently never applies.
      hardware.trackpoint = {
        enable = true;
        device = "TPPS/2 Synaptics TrackPoint";
        # sensitivity = 128; # 0-255, driver-level, works on Wayland
        # speed = 97;        # 0-255, driver-level, works on Wayland
        # NOTE: emulateWheel is X11-only (inputClassSections) and ignored by
        # niri — middle-button scrolling is configured in niri's trackpoint
        # block via scroll-method = "on-button-down" instead.
      };

      # Fingerprint reader (present on most T14 Gen3 SKUs; harmless if absent)
      services.fprintd.enable = true;

      # Suspend-friendly: niri + noctalia handle lock; enable hibernate via swap
      services.logind.settings.Login.HandlePowerKey = "suspend";
    };
}
