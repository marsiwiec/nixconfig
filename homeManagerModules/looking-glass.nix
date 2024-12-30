{
  config,
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  programs.looking-glass-client = {
    enable = true;
    package = pkgs-stable.looking-glass-client;
    settings = {
      app = {
        allowDMA = true;
        shmFile = "/dev/kvmfr0";
      };
      win = {
        fullScreen = true;
        showFPS = false;
        jitRender = true;
      };
      spice = {
        enable = true;
        audio = true;
      };
    };
  };
}
