{
  lib,
  pkgs,
  config,
  ...
}:
{
  options = {
    distrobox.enable = lib.mkEnableOption "config for distrobox with podman";
  };

  config = lib.mkIf config.distrobox.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
    environment.systemPackages = with pkgs; [
      distrobox
      boxbuddy
    ];
  };
}
