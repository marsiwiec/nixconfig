{
  flake.modules.homeManager.print3d =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        bambu-studio
        orca-slicer
      ];
    };
}
