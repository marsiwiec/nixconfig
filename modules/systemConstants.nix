# Declares a top-level option that is used in other modules.
{ self, ... }:
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
        wallpaperDir = "${self}/assets/wallpapers";
        iconDir = "${self}/assets/icons";
        avatar = "${self}/assets/avatars/neuron.png";
      };
    };
}
