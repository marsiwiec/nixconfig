{
  lib,
  config,
  pkgs,
  ...
}:
{

  options = {
    graphics.enable = lib.mkOption {
      type = lib.types.bool;
      description = "enable some desktop graphics packages";
      default = true;
    };
  };

  config = lib.mkIf config.graphics.enable {
    home.packages = with pkgs; [
      inkscape-with-extensions
      gimp
      (blender.override {
        cudaSupport = true;
      })
    ];
  };
}
