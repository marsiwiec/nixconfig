{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    zed.url = "github:zed-industries/zed";
  };

  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [
      (final: prev: {
        zed-editor = inputs.zed.packages.${final.stdenv.hostPlatform.system}.default;
      })
    ];
  };

  flake.modules.homeManager.zed =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        zed-editor
      ];
    };
}
