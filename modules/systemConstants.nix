# Declares a top-level option that is used in other modules.
{
  flake.modules.generic.systemConstants =
    { lib, ... }:
    {
      options.systemConstants = lib.mkOption {
        type = lib.types.attrsOf lib.types.unspecified;
        default = { };
      };

      config.systemConstants = {
        username = "msiwiec";
        wallpaperDir = ../assets/wallpapers;
        iconDir = ../assets/icons;
        avatar = ../assets/avatars/neuron.png;
      };
    };
}
