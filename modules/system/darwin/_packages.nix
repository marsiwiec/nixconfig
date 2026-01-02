{
  config,
  inputs,
  vars,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    user = vars.userName;
  };
  homebrew = {
    enable = true;
    global = {
      autoUpdate = true;
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [
      "nikitabobko/tap"
      "r-lib/rig"
      "BarutSRB/tap"
    ];
    casks = [
      "alfred"
      "macfuse"
      # "omniwm"
      # "aerospace"
      "rig"
      "rstudio"
      "positron"
      "libreoffice"
    ];
  };
}
