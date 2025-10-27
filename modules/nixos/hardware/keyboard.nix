{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    keyboard.enable = lib.mkEnableOption "keyboard config";
  };
  config = lib.mkIf config.keyboard.enable {
    environment.systemPackages = with pkgs; [
      keymapp
    ];
    hardware.keyboard.zsa.enable = true;
  };
}
