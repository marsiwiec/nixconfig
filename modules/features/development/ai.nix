{
  flake.modules.homeManager.ai =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gemini-cli-bin
        claude-code
        claude-monitor
      ];
    };
}
