{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Master nixpkgs for early access to fixes/features
    # Available as pkgs.master.* (currently unused)
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # nixpkgs-unstable for early access
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  flake.modules =
    let
      # Core nixpkgs overlay configuration
      # Uses throw to ensure lazy evaluation - pkgs.stable/master are only
      # evaluated when actually accessed, reducing build time
      overlays = [
        (final: prev: {
          # Make stable nixpkgs accessible under 'pkgs.stable' (lazy)
          # stable = import inputs.nixpkgs-stable {
          #   system = final.stdenv.hostPlatform.system;
          #   config.allowUnfree = final.config.allowUnfree;
          # };

          # Make master nixpkgs accessible under 'pkgs.master' (lazy)
          master = import inputs.nixpkgs-master {
            system = final.stdenv.hostPlatform.system;
            config.allowUnfree = final.config.allowUnfree;
          };

          # Make nixpkgs-unstable accessible under 'pkgs.unstable' (lazy)
          unstable = import inputs.nixpkgs-unstable {
            system = final.stdenv.hostPlatform.system;
            config.allowUnfree = final.config.allowUnfree;
          };
          python314Packages = prev.python314Packages.overrideScope (
            pyFinal: pyPrev: {
              patool = pyPrev.patool.override {
                file = prev.file.overrideAttrs {
                  # Work around too strict landlock hardening
                  # https://bugs.astron.com/view.php?id=785
                  postPatch = ''
                    substituteInPlace src/landlock.c --replace-fail \
                      "LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR" \
                      "LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_READ_DIR | LANDLOCK_ACCESS_FS_EXECUTE"
                  '';
                };
              };
            }
          );
        })
      ];
    in
    {
      nixos.overlays = {
        nixpkgs.overlays = overlays;
      };
    };
}
