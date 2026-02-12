{ inputs, ... }:
{
  flake-file.inputs = {
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };
  flake.modules.homeManager.spicetify =
    { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [
        inputs.spicetify-nix.homeManagerModules.default
      ];
      programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          hidePodcasts
        ];
      };
    };
}
