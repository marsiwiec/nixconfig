{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    dank-material-shell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [
      (final: _prev: {
        dms = inputs.dank-material-shell.packages.${final.stdenv.hostPlatform.system}.default;
      })
    ];
  };
}
