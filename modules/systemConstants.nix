# Declares a top-level option that is used in other modules.
{
  flake.modules.nixos.systemConstants =
    { lib, ... }:
    {
      options.systemConstants = {
        username = lib.mkOption {
          type = lib.types.str;
          default = "msiwiec";
        };
        wallpaperDir = lib.mkOption {
          type = lib.types.path;
          default = ../assets/wallpapers;
        };
        iconDir = lib.mkOption {
          type = lib.types.path;
          default = ../assets/icons;
        };
        avatar = lib.mkOption {
          type = lib.types.path;
          default = ../assets/avatars/neuron.png;
        };
      };
    };
}
