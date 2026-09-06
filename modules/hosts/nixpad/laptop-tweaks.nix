{ lib, ... }:
{
  flake.modules.nixos.nixpad-laptop =
    { pkgs, ... }:
    {
      boot.kernelModules = [ "thinkpad_acpi" ];

      services.tlp.enable = true;
      # noctalia enables `services.power-profiles-daemon` by default via its
      # recommendedServices; its power menu talks to PPD over DBus. `tlp.pd`
      # provides the same power-profiles-daemon DBus interface backed by TLP
      # profiles, so we swap PPD out for it instead of losing the feature.
      services.tlp.pd.enable = true;
      services.power-profiles-daemon.enable = lib.mkForce false;
      services.tlp.settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };

      # powertop stays installed for measurement only (`sudo powertop`);
      # its boot auto-tune service is gone since TLP owns those tunables.
      environment.systemPackages = with pkgs; [
        lm_sensors
        powertop
      ];

      # Firmware updates via LVFS (UEFI BIOS, webcam, touchpad, CPU/GPU, TPM,
      # NVMe all supported on the T14 G3). Usage: fwupdmgr refresh / get-updates / update
      services.fwupd.enable = true;

      # Upower is needed by noctalia's battery widget
      services.upower.enable = true;

      services.apcupsd.enable = lib.mkForce false;

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

      # ---- Suspend/Hibernate (s2idle only on this APU; no S3) ----
      # Lid close = suspend-then-hibernate: fast s2idle wake for short
      # closures, auto-hibernate after HibernateDelaySec (30 min) so long
      # closures drop to zero power. Power key does a normal s2idle suspend.
      # Docked stays awake & usable with external display.
      services.logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandleLidSwitchDocked = "ignore";
      };

systemd.sleep.settings.Sleep.HibernateDelaySec = "30min";
    };
}
