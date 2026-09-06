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
        (llama-cpp.override {
          cudaSupport = true;
        })
      ];
      nix.settings = {
        extra-substituters = [ "https://cache.nixos-cuda.org" ];
        extra-trusted-public-keys = [
          "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
      };
    };
}
