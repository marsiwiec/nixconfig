{
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos.default-settings =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        audio
        bluetooth
        boot
        fonts
        graphics
        home-manager
        keyboard
        locale
        logitech
        networking
        nh
        power
        printing
        screen
        security-defaults
        shell
        ssh
        sops
        stylix
        tailscale
        time
        utils
        virtualisation
      ];

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc
          fuse3
          cmake
          gnumake
          glib
          glibc
          zlib
        ];
      };

      fileSystems = lib.mkDefault {
        "/".options = [ "compress=zstd" ];
        "/home".options = [ "compress=zstd" ];
        "/nix".options = [
          "compress=zstd"
          "noatime"
        ];
      };
      services.btrfs.autoScrub.enable = true;
    };
}
