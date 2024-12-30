{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    zotero.enable = lib.mkEnableOption "enable zotero ref management";
  };
  config = lib.mkIf config.zotero.enable {
    home.packages = with pkgs; [
      zotero
    ];
  };
}
