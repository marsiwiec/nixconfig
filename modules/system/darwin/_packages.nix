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
      "r-lib/rig"
    ];
    casks = [
      "alfred"
      "gimp"
      "inkscape"
      "libreoffice"
      "macfuse"
      "positron"
      "rig"
      "rstudio"
      "utm"
      "vlc"
    ];
  };
}
