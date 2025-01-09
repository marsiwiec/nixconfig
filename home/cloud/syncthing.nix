{ lib, config, ... }:
{
  options = {
    syncthing.enable = lib.mkEnableOption "syncthing config";
  };
  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      settings = {
        user = "msiwiec";
        configDir = "/home/msiwiec/.config/syncthing";
        dataDir = "/home/msiwiec/Documents";
        devices = {
          nixgroot = {
            name = "nixgroot";
            id = "OHDWGNL-ZKXTFC6-H4UD236-2ZNBQP6-FQFUOS6-QOVENNW-MTBLWP3-B2D4WA4";
          };
          labnix = {
            name = "labnix";
            id = "VS33NBI-U57M5JI-3BLPP7X-2PJ6HNG-VACPDFX-2MMJLGJ-NE5H4IY-5DCTDQR";
          };
          nixcloud = {
            name = "nixcloud";
            id = "BRKNJ2L-KUTOHBD-JI57IX5-42BTHTO-NNFIWNZ-ZUR5XZM-66GBYGX-FESONAH";
          };
        };
        folders = {
          zotero = {
            path = "/home/msiwiec/Documents/zotero";
            versioning = {
              type = "simple";
              params = {
                keep = "10";
                cleanoutDays = "0";
              };
            };
            devices = [
              "nixgroot"
              "labnix"
              "nixcloud"
            ];
          };
        };
      };
    };
    systemd.user.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  };
}
