{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    niri.enable = lib.mkEnableOption "enable niri WM";
  };
  config = lib.mkIf config.niri.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    services = {
      dbus.implementation = "broker";
      accounts-daemon.enable = true;
    };

    systemd.user.services = {
      niri-flake-polkit.enable = false;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
      libsecret
      cage
      gamescope
      xwayland-satellite
      swaybg
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      seahorse.enable = true; # pass + encryption management
    };
  };
}
