{
  flake.modules.nixos.nixgroot-filesystem = {

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/af5dc428-bd74-4012-97af-c9db8b02755b";
      fsType = "btrfs";
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/af5dc428-bd74-4012-97af-c9db8b02755b";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/af5dc428-bd74-4012-97af-c9db8b02755b";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    fileSystems."/home/msiwiec/Games" = {
      device = "/dev/disk/by-uuid/ba3094ab-71c9-43be-8ae3-48510a13676d";
      fsType = "btrfs";
      options = [ "compress=zstd" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/2F7B-0FC7";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];
  };
}
