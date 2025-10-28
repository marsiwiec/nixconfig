{ pkgs, vars, ... }:
{
  imports = [
    ./_packages.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
    };
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "@admin"
      ];
    };
  };
  ids.gids.nixbld = 350;

  programs.zsh.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  services = {
    tailscale.enable = true;
  };

  system = {
    primaryUser = vars.userName;
    startupChime = false;
    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        tilesize = 96;
        mvous-br-corner = 4;
        mvous-bl-corner = 11;
        mvous-tr-corner = 5;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
      };
      menuExtraClock = {
        ShowSeconds = true;
        Show24Hour = true;
        ShowAMPM = false;
      };
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };
    };
  };
  system.stateVersion = 4;
}
