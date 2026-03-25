{
  flake.modules.nixos.containers =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      virtualisation = {
        podman = {
          enable = true;
          dockerCompat = true;
        };
      };
      environment.systemPackages = with pkgs; [
        distrobox
        boxbuddy

        podman-compose
      ];

      services.flatpak.packages = lib.mkIf config.services.flatpak.enable [
        "io.podman_desktop.PodmanDesktop"
      ];
    };
}
