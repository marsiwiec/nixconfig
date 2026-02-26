{
  flake.modules.homeManager.blender =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # (blender.override { cudaSupport = true; })
        blender
      ];
    };
}
