{
  flake.modules.homeManager.ai =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        gemini-cli-bin
        lmstudio
        nodejs
      ];
      programs.opencode = {
        enable = true;
      };
    };
}
