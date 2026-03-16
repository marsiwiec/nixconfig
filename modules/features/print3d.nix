{ lib, ... }:
{
  flake.modules = {
    homeManager.print3d =
      { osConfig, ... }:
      {
        services.flatpak.packages = lib.mkIf osConfig.services.flatpak.enable [
          "com.bambulab.BambuStudio"
        ];
      };
  };
}
