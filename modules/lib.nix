{
  inputs,
  lib,
  ...
}:
{
  # Helper functions for creating system / home-manager configurations
  options.flake.lib = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
  config.flake.lib = {
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.self.modules.nixos.${name}
          inputs.self.modules.nixos.overlays
          inputs.self.modules.generic.systemConstants
          { nixpkgs.hostPlatform = lib.mkDefault system; }
        ];
      };
    };
  };
}
