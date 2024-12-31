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
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      optimise = {
        automatic = true;
        dates = [ "03:45" ];
      };
    };
  };
}
