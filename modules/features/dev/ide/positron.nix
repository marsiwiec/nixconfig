{
  flake.modules.homeManager.positron =
    { pkgs, ... }:
    {
      home.packages = with pkgs.unstable; [
        positron-bin
      ];
    };
}
