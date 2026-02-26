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
          gnumeric
          # super-productivity
        ];
        programs.zathura.enable = true;
        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
          };
        };
      })
      (lib.mkIf (pkgs.stdenv.isDarwin) {
        home.packages = with pkgs; [
          libreoffice-bin
        ];
      })
    ];
}
