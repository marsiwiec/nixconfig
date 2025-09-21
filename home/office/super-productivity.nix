{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    super-productivity.enable = lib.mkEnableOption "enable super-productivity note app";
  };
  config = lib.mkIf config.super-productivity.enable {
    home.packages = with pkgs; [
      (super-productivity.overrideAttrs (old: {
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "super-productivity";
            desktopName = "superProductivity";
            exec = "super-productivity --ozone-platform=x11 %u";
            terminal = false;
            type = "Application";
            icon = "super-productivity";
            startupWMClass = "superProductivity";
            comment = "ToDo list and Time Tracking";
            categories = [
              "Office"
              "ProjectManagement"
            ];
          })
        ];
      }))
    ];
  };
}
