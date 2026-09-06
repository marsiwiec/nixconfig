{
  inputs,
  config,
  ...
}: let
  # Desktop shell selection: name -> nixos shell module. The homeManager
  # keybinds mode matches the shell name (see keybinds.nix).
  shells = {
    dms = inputs.self.modules.nixos.dank-material-shell;
    noctalia = inputs.self.modules.nixos.noctalia;
  };

  keybinds = config.flake.factory.niriKeybinds;
in {
  # Factory aspect: a desktop (shell + matching keybinds) as one unit.
  #   dms      -> dank-material-shell with dms keybinds
  #   noctalia -> noctalia with noctalia keybinds
  # Usage: (inputs.self.factory.desktopShell "dms") in a host's imports.
  config.flake.factory.desktopShell = name:
    {
      imports = [ shells.${name} ];
      home-manager.sharedModules = [ (keybinds name) ];
    };
}