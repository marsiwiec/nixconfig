{...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  services.dbus.implementation = "broker";
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
