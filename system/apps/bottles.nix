{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    bottles.enable = lib.mkEnableOption "enable bottles";
  };
  config = lib.mkIf config.bottles.enable {
    environment.systemPackages = with pkgs; [
      (bottles.override { removeWarningPopup = true; })
    ];
  };
}
