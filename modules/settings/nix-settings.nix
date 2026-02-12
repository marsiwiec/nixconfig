{
  flake.modules.generic.nix-settings = {
    nix = {
      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 90d";
      };
      optimise = {
        automatic = true;
        dates = [ "03:45" ];
      };
      settings = {
        warn-dirty = false;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        trusted-users = [
          "@wheel"
        ];
      };
    };
    nixpkgs.config.allowUnfree = true;
  };
}
