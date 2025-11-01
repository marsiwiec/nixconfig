{ pkgs, vars, ... }:
{
  imports = [
    ./_packages.nix
    ../../../modules/system/nixos/apps/dev
    ../../../modules/system/nixos/apps/tailscale.nix
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
  programs.zsh.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = with pkgs; [
    nh
  ];
  services = {
    tailscale.enable = true;
    skhd = {
      enable = true;
      skhdConfig = ''
        cmd - return : open -a wezterm
        alt + shift - return : open -a firefox
      '';
    };
  };

  system = {
    primaryUser = vars.userName;
    startup.chime = false;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      dock = {
        autohide = true;
        orientation = "left";
        mru-spaces = false;
        tilesize = 64;
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
        _HIHideMenuBar = true;
      };
    };
  };
}
