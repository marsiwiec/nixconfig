{
  lib,
  config,
  ...
}:
{
  options = {
    gc.enable = lib.mkEnableOption "config for garbage collection and store optimization";
  };

  config = lib.mkIf config.gc.enable {
    nix = {
      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 90d";
      };
      optimise = {
        automatic = true;
        dates = [ "03:45" ];
      };
    };
  };
}
