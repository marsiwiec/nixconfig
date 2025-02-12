{ lib, pkgs, ... }:
{
  options = {
    vscode.enable = lib.mkEnableOption "vscode inside FHS compliant chroot env";
  };
  config = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (
        ps: with ps; [
          rustup
          zlib
          openssl.dev
          pkg-config
        ]
      );
    };
  };
}
