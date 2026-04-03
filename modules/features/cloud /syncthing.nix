{
  flake.modules.homeManager.syncthing = {
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
            id = "G2GCZQ7-3VUGKZ2-YFWYNDM-SODAD27-ZOPZQKO-AZAC5WL-QLJQQXS-PXGA6QR";
          };
          labnix = {
            name = "labnix";
            id = "PVREYAJ-J3Y2ZE5-SSBEXZG-336PJNT-5YHGUOY-WBWPGZI-G635EFU-UJCFAQ2";
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
