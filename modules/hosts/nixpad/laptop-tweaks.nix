{
  flake.modules.nixos.nixpad-laptop =
    { pkgs, ... }:
    {
      # ThinkPad-specific extras: fan control, battery and hotkeys via thinkpad_acpi
      boot.kernelModules = [ "thinkpad_acpi" ];

      # Power/efficiency tweaks for the AMD Ryzen PRO (Rembrandt) APU
      services.power-profiles-daemon.enable = true;

      # Firmware updates via LVFS (UEFI BIOS, webcam, touchpad, CPU/GPU, TPM,
      # NVMe all supported on the T14 G3). Usage: fwupdmgr refresh / get-updates / update
      services.fwupd.enable = true;

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

      # ---- Suspend (s2idle only on this APU; no S3) ----
      # Explicit lid/power handling. Lid close suspends; power key suspends.
      services.logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
        HandleLidSwitchDocked = "ignore"; # stay awake when docked with lid closed
      };

      # Known ath11k_pci suspend/resume bug on this platform (ArchWiki
      # T14 AMD G3): the module can block resume, freeze the GPU, or cause an
      # immediate spurious wake. Unload it before sleep, reload after.
      # WiFi reconnects in ~1-2s on resume; imperceptible vs. resume time.
      systemd.services.ath11k-suspend = {
        description = "Unload ath11k_pci before suspend";
        before = [ "sleep.target" ];
        wantedBy = [ "sleep.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.kmod}/bin/rmmod ath11k_pci";
        };
      };
      systemd.services.ath11k-resume = {
        description = "Reload ath11k_pci after resume";
        after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
        wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.kmod}/bin/modprobe ath11k_pci";
        };
      };
    };
}
