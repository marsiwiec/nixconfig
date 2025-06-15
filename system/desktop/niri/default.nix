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

    programs = {
      niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
    };
  };
}
