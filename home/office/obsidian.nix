{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    obsidian.enable = lib.mkEnableOption "enable obsidian note app";
  };
  config = lib.mkIf config.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
