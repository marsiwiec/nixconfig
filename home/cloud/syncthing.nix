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
            id = "EWRXSIL-W2OZVRK-PYS6ATQ-76MKITY-JJFMEBO-BKMPEQJ-JEUAURW-FM67XAN";
          };
          labnix = {
            name = "labnix";
            id = "VS33NBI-U57M5JI-3BLPP7X-2PJ6HNG-VACPDFX-2MMJLGJ-NE5H4IY-5DCTDQR";
          };
          qnap = {
            name = "qnap";
            id = "KSFW7A3-GW5NQ64-KHVLDFD-NIJGQU6-WBEHWOE-LVRAQGL-BK6LVRE-EQ73VA6";
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
              "qnap"
            ];
          };
        };
      };
    };
    systemd.user.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  };
}
