{
  lib,
  config,
  ...
}:
{
  options = {
    nixpkgs.enable = lib.mkEnableOption "config for nixpkgs regarding unfree etc";
  };
  config = lib.mkIf config.nixpkgs.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
