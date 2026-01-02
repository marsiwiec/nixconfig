{ pkgs, vars, ... }:
{
  imports = [
    ../common
    ./_packages.nix
  ];

  R.enable = false;
  tailscale.enable = false;

  nixpkgs.config.allowUnfree = true;
  nix = {
    enable = false;
    #   settings = {
    #     experimental-features = "nix-command flakes";
    #     trusted-users = [
    #       "root"
    #       "@admin"
    #     ];
    #   };
  };
  programs.zsh.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  environment.systemPackages = with pkgs; [
    nh
  ];
  services = {
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
        tilesize = 48;
      };
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
      };
      menuExtraClock = {
        Show24Hour = true;
        ShowAMPM = false;
      };
      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        # _HIHideMenuBar = true;
      };
    };
  };
}
