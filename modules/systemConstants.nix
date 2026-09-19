# Declares a top-level option that is used in other modules.
{ self, ... }:
{
  flake.modules.generic.systemConstants =
    { lib, ... }:
    {
      options.systemConstants = {
        username = lib.mkOption {
          type = lib.types.str;
          default = "msiwiec";
        };
        wallpaperDir = lib.mkOption {
          type = lib.types.path;
          default = "${self}/assets/wallpapers";
        };
        iconDir = lib.mkOption {
          type = lib.types.path;
          default = "${self}/assets/icons";
        };
        avatar = lib.mkOption {
          type = lib.types.path;
          default = "${self}/assets/avatars/neuron.png";
        };
        terminal = lib.mkOption {
          type = lib.types.str;
          default = "footclient";
        };
        browser = lib.mkOption {
          type = lib.types.str;
          default = "firefox";
        };
        filemanager = lib.mkOption {
          type = lib.types.str;
          default = "thunar";
        };
      };
    };
}
