{
  flake.modules.nixos.nixgroot = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/15a37742-fbb6-4f2a-9928-5475762ff986";
        fsType = "btrfs";
        options = [ "subvol=root" ];
      };

      "/nix" = {
        device = "/dev/disk/by-uuid/15a37742-fbb6-4f2a-9928-5475762ff986";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

      "/home" = {
        device = "/dev/disk/by-uuid/fbc2dd82-45f4-4fc9-968a-f13e68201a3d";
        fsType = "btrfs";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/19CC-F4B9";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
    };
    swapDevices = [ ];
  };
}
