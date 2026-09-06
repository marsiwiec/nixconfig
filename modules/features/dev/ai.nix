{
  lib,
  ...
}: let
  llamaCppOverride = backend:
    if backend == "cuda" then
      {
        cudaSupport = true;
      }
    else if backend == "rocm" then
      {
        rocmSupport = true;
        rocmPackages = null;
      }
    else
      { };
in {
  config =
    {
      flake.modules.homeManager.ai =
        { pkgs, ... }:
        {
          programs = {
            opencode.enable = true;
            pi-coding-agent.enable = true;
          };
          home.packages = with pkgs; [
            nodejs
          ];
        };

      # Factory aspect: llama-cpp GPU backend is host-dependent.
      #   cuda  -> nixgroot (NVIDIA)
      #   rocm  -> labnix (AMD dGPU), rocmPackages filled at module eval
      #   cpu   -> nixpad (AMD Rembrandt iGPU, no official ROCm support)
      flake.factory.llamaCpp = backend:
        { ... }:
        {
          home-manager.sharedModules = [
            (
              {
                pkgs,
                lib,
                ...
              }:
              {
                home.packages = [
                  (pkgs.llama-cpp.override (
                    llamaCppOverride backend
                    // (lib.optionalAttrs (backend == "rocm") {
                      rocmPackages = pkgs.rocmPackages;
                    })
                  ))
                ];
                nix.settings = lib.mkIf (backend == "cuda") {
                  extra-substituters = [ "https://cache.nixos-cuda.org" ];
                  extra-trusted-public-keys = [
                    "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
                  ];
                };
              }
            )
          ];
        };
    };
}