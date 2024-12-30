{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    libreoffice.enable = lib.mkEnableOption "enable LibreOffice";
  };

  config = lib.mkIf config.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
