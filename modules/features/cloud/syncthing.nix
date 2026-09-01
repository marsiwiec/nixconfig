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
            id = "4CEZVD4-OCVN6D4-PXIJIAB-QVRH3GC-VDFDQWV-PT3J25F-AEKJEON-JXHUWQH";
          };
          labnix = {
            name = "labnix";
            id = "PVREYAJ-J3Y2ZE5-SSBEXZG-336PJNT-5YHGUOY-WBWPGZI-G635EFU-UJCFAQ2";
          };
          nixpad = {
            name = "nixpad";
            id = "BJQNGQ3-XETJ7LU-LJHR45H-2LG3P5Z-H6AFKT7-R6PUNX6-YRIPHXX-A6TDNQA";
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
              "nixpad"
              "qnap"
            ];
          };
        };
      };
    };
    systemd.user.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
  };
}
