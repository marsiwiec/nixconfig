{
  lib,
  config,
  pkgs-stable,
  ...
}: {
  options = {
    looking-glass.enable = lib.mkEnableOption "enable looking glass config for GPU passthrough";
  };

  config = lib.mkIf config.looking-glass.enable {
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
  };
}
