{
  flake.modules.nixos.screen =
    { pkgs, ... }:
    {
      hardware.i2c.enable = true;
      services.udev.extraRules = ''
        KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
      '';
      environment.systemPackages = with pkgs; [
        ddcutil
      ];
      programs.light.enable = true;
    };
}
