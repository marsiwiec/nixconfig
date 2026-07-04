{
  flake.modules.nixos.nixgroot-cooling =
    { config, pkgs, ... }:
    {
      # Enable the Nuvoton Super I/O driver used on the ASUS TUF GAMING X670E-PLUS WIFI.
      # This provides the motherboard fan headers (including CPU_FAN), voltages and
      # additional temperatures, plus the PWM controls that CoolerControl needs.
      boot.kernelModules = [ "nct6775" ];

      # Install the lm_sensors user-space tools (sensors, sensors-detect, pwmconfig, ...).
      environment.systemPackages = with pkgs; [ lm_sensors ];

      # Enable CoolerControl for the GUI fan/pump curve editor.
      programs.coolercontrol.enable = true;

      # Human-readable labels for the sensors we already know about.
      # The asusec chip comes from the mainline asus-ec-sensors driver.
      # The nct6799 chip comes from the mainline nct6775 Super I/O driver.
      environment.etc."sensors.d/tuf-x670e-plus-wifi.conf".text = ''
        chip "asusec-*"
          label temp1 "CPU"
          label temp2 "CPU Package"
          label temp3 "Motherboard"
          label temp4 "VRM"
          label temp5 "Water In"
          label temp6 "Water Out"
          label fan1  "CPU Opt Fan"

        chip "nct6799-*"
          label temp1  "SuperIO SYSTIN"
          label temp2  "SuperIO CPUTIN"
          label temp3  "SuperIO AUXTIN0"
          label temp4  "SuperIO AUXTIN1"
          label temp5  "SuperIO AUXTIN2"
          label temp6  "SuperIO AUXTIN3"
          label temp7  "SuperIO AUXTIN4"
          label temp8  "SuperIO PECI Agent 0"
          label temp9  "SuperIO AUXTIN5"
          label temp10 "PCH Chip CPU Max"
          label temp11 "PCH Chip"
          label temp12 "PCH CPU"
          label temp13 "TSI0"
      '';
    };
}
