{ lib, config, ... }:
{
  options = {
    syncthing.enable = lib.mkEnableOption "syncthing config";
  };
  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      overrideFolders = true;
      overrideDevices = true;
      settings = {
        user = "msiwiec";
        configDir = "~/.config/syncthing";
        dataDir = "~/Documents";
        devices = {
          nixgroot = {
            name = "nixgroot";
            id = "EWRXSIL-W2OZVRK-PYS6ATQ-76MKITY-JJFMEBO-BKMPEQJ-JEUAURW-FM67XAN";
          };
          labnix = {
            name = "labnix";
            id = "VS33NBI-U57M5JI-3BLPP7X-2PJ6HNG-VACPDFX-2MMJLGJ-NE5H4IY-5DCTDQR";
          };
          macnix = {
            name = "macnix";
            id = "4FXETP4-QCPRETB-LQZPJI4-5QDJ2EV-D6URIJR-BYPCD77-7YSTGWB-VD74GQ6";
          };
          qnap = {
            name = "qnap";
            id = "KBS4QQF-7CHDIAR-RJSTU7O-NECPLPN-IBFWARQ-PGMDMEW-WTRFFFG-FIVT3AM";
          };
        };
        folders = {
          zotero = {
            path = "~/Documents/zotero";
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
              "macnix"
              "qnap"
            ];
          };
        };
      };
    };
    systemd.user.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  };
}
