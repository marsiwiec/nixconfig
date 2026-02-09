{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    nixld.enable = lib.mkEnableOption "nixld config for dynamic libraries";
  };
  config = lib.mkIf config.nixld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        glib
        glibc
        zlib
      ];
    };
  };
}
