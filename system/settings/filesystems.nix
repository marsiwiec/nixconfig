{
  lib,
  config,
  ...
}: {
  options = {
    filesystems.enable = lib.mkEnableOption "filesystems config for btrfs partitions";
  };

  config = lib.mkIf config.filesystems.enable {
    # Set up mount options for btrfs
    fileSystems = {
      "/".options = ["compress=zstd"];
      "/home".options = ["compress=zstd"];
      "/nix".options = [
        "compress=zstd"
        "noatime"
      ];
    };
    services.btrfs.autoScrub.enable = true;
  };
}
