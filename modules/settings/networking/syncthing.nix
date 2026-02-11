{ config, ... }:
# let
#   username = config.systemConstants.username;
# in
{
  flake.modules.generic.syncthing = {
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
            id = "AWTAL37-2RF3F5N-D652ZXD-FCOHPUC-2IGHBR4-JQGCDCK-QWRAHED-56A2AAN";
          };
          qnap = {
            name = "qnap";
            id = "FMN6MED-5R4ZDLT-Y5KMXYP-T7EE4UV-CJRJM37-ZFSVOKP-VQ4VX25-5QW6XAV";
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
