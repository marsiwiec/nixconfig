{
  lib,
  config,
  ...
}: {
  options = {
    hyprland.enable = lib.mkEnableOption "enable Hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    services.dbus.implementation = "broker";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
