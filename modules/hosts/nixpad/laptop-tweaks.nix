{ lib, ... }:
{
  flake.modules.nixos.nixpad-laptop =
    { pkgs, ... }:
    {
      boot.kernelModules = [ "thinkpad_acpi" ];
      boot.blacklistedKernelModules = [ "amd_sfh" ];

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
      # systemd's own suspend-then-hibernate is unusable here: it arms rtc0
      # (acpi-tad), which cannot wake this APU out of s2idle, so the 30-min
      # transition never fires and instead runs the pending hibernate at the
      # moment of a manual wake (causing a crash). rtc1 (rtc_cmos) CAN wake,
      # so we implement the delay ourselves via /etc/systemd/system-sleep
      # hook `nixpad-rtc-suspend` (defined below).
      #
      # Lid close (AC and battery) = plain s2idle suspend: stays asleep,
      # wakes instantly on lid open. The hook then auto-hibernates battery
      # closures after 30 min, keeps re-suspending on AC, and recognises an
      # unplug-while-suspended within ~30 min. Power key = plain suspend.
      # Docked stays awake & usable with external display.
      services.logind.settings.Login = {
        HandlePowerKey = "suspend";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
        HandleLidSwitchDocked = "ignore";
      };

      # RTC-driven suspend-then-hibernate with a wake-capable RTC (rtc_cmos).
      # The hook keeps DELAY below in sync with the 30-min cadence this
      # policy is built around.
      environment.etc."systemd/system-sleep/nixpad-rtc-suspend" = {
        source = pkgs.writeShellScript "nixpad-rtc-suspend" ''
          # systemd-sleep hook: arms rtc_cmos (wake-capable) so this s2idle-only
          # APU can self-wake; on wake, decide by lid/power.
          # Args: $1=pre|post, $2=suspend|suspend-then-hibernate|hibernate|...
          # NOTE: hooks run with a minimal PATH, so every external command
          # must be an absolute store path.
          set +e
          DATE=${pkgs.coreutils}/bin/date
          RM=${pkgs.coreutils}/bin/rm
          CAT=${pkgs.coreutils}/bin/cat
          GREP=${pkgs.gnugrep}/bin/grep
          LID=/proc/acpi/button/lid/LID/state
          AC=/sys/class/power_supply/AC/online
          STATE=/run/nixpad-rtc-target
          SYSTEMCTL=/run/current-system/sw/bin/systemctl
          SYSTEMDRUN=/run/current-system/sw/bin/systemd-run
          DELAY=1800 # 30 min — battery auto-hibernate delay; rtc_cmos self-wake cadence on AC

          # Select the wake-capable RTC by name (rtc_cmos), not by number —
          # kernels enumerate RTCs in different orders (rtc_cmos has been both
          # rtc0 and rtc1 across 7.2.x). acpi-tad (rtc1) cannot wake s2idle.
          RTC=""
          for d in /sys/class/rtc/rtc*; do
            if "$GREP" -q "rtc_cmos" "$d/name" 2>/dev/null; then
              RTC="$d/wakealarm"
              break
            fi
          done
          : "''${RTC:=/sys/class/rtc/rtc1/wakealarm}"

          lid_closed() { "$GREP" -q 'closed' "$LID" 2>/dev/null; }
          on_battery() { [ "$("$CAT" "$AC" 2>/dev/null)" = "0" ]; }

          case "$1:$2" in
            pre:suspend*)
              if lid_closed; then
                echo 0 > "$RTC" 2>/dev/null
                target=$(( $("$DATE" +%s) + DELAY ))
                echo "$target" > "$RTC" 2>/dev/null
                echo "$target" > "$STATE" 2>/dev/null
              else
                echo 0 > "$RTC" 2>/dev/null
                "$RM" -f "$STATE"
              fi
              ;;
            post:suspend*)
              echo 0 > "$RTC" 2>/dev/null
              target=$("$CAT" "$STATE" 2>/dev/null) || exit 0
              "$RM" -f "$STATE"
              if ! lid_closed; then
                exit 0
              fi
              if [ "$("$DATE" +%s)" -ge "$target" ]; then
                if on_battery; then
                  "$SYSTEMDRUN" --quiet --collect --unit=nixpad-hibernate --no-block -- "$SYSTEMCTL" hibernate
                else
                  "$SYSTEMDRUN" --quiet --collect --unit=nixpad-resuspend --no-block -- "$SYSTEMCTL" suspend
                fi
              else
                "$SYSTEMDRUN" --quiet --collect --unit=nixpad-resuspend --no-block -- "$SYSTEMCTL" suspend
              fi
              ;;
            *) echo 0 > "$RTC" 2>/dev/null; "$RM" -f "$STATE" ;;
          esac
        '';
      };
    };
}
