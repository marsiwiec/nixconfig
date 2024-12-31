{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    rclone.enable = lib.mkEnableOption "enable rclone for cloud storage";
  };

  config = lib.mkIf config.rclone.enable {
    home.packages = with pkgs; [
      rclone
    ];
  };
}
