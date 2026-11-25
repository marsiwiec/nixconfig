{
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      # Use our own (root) firefox-gnome-theme input instead of stylix's pin,
      # so a plain `nix flake update` keeps it current.
      inputs.firefox-gnome-theme.follows = "firefox-gnome-theme";
    };
  };
}
