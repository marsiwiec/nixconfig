{
  flake.modules.homeManager.ai =
    { pkgs, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
      };
      home.packages = with pkgs; [
        nodejs
      ];
    };
}
