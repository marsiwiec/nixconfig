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
    ];
    casks = [
      # "rstudio"
      "aerospace"
      "positron"
      "the-unarchiver"
      "vlc"
    ];
  };
}
