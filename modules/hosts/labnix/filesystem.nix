{
  flake.modules.nixos.labnix = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/bf35f6ff-4942-45cf-aebd-3626dfeaf5ab";
        fsType = "btrfs";
        options = [ "subvol=root" ];
      };

      "/nix" = {
        device = "/dev/disk/by-uuid/bf35f6ff-4942-45cf-aebd-3626dfeaf5ab";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };

      "/home" = {
        device = "/dev/disk/by-uuid/bf35f6ff-4942-45cf-aebd-3626dfeaf5ab";
        fsType = "btrfs";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/410C-53D2";
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
