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
    enableRosetta = true;
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
    casks = [
      "wezterm"
      "firefox"
      "obsidian"
      "positron"
      "spotify"
      "steam"
      "the-unarchiver"
      "vlc"
    ];
    masApps = {
      "Tailscale" = 1475387142;
    };
  };
}
