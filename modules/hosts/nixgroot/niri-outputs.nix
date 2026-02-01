{
  flake.modules.homeManager.niri-outputs-nixgroot = {
    programs.niri.settings.outputs = {
      "DP-1" = {
        mode.width = 2560;
        mode.height = 1440;
        mode.refresh = 74.924004;
      };
      "HDMI-A-2" = {
        enable = false;
      };
    };
    spawn-at-startup = [
      {
        command = [
          "sudo"
          "nvidia-enable"
        ];
      }
    ];
  };
}
