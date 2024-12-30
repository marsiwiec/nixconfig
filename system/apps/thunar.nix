{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    thunar.enable = lib.mkEnableOption "config for thunar file manager";
  };

  config = lib.mkIf config.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    environment.systemPackages = with pkgs; [
      xarchiver
    ];
  };
}
