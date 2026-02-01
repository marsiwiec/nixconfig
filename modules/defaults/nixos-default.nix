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
        overlays
        nix-settings
        locale
        security-defaults
        nh
        sops
        shell
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
      # Default filesystem layout common for every NixOS build
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
