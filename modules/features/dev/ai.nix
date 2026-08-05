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
}
