{ lib, ... }:
{
  flake.modules.homeManager.office =
    { pkgs, ... }:
    lib.mkMerge [
      {
        home.packages = with pkgs; [
          obsidian
          zotero
        ];
      }
      (lib.mkIf (pkgs.stdenv.isLinux) {
        home.packages = with pkgs; [
          libreoffice
          super-productivity
        ];
      })
      (lib.mkIf (pkgs.stdenv.isDarwin) {
        home.packages = with pkgs; [
          libreoffice-bin
        ];
      })
    ];
}
