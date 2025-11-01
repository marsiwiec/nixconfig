{
  lib,
  pkgs,
  vars,
  inputs,
  ...
}:
{
  imports = [
    ./browsers
    ./cloud
    ./desktop
    ./editors
    ./graphics
    ./media
    ./nixgroot
    ./office
    ./terminal
  ];

  home = {
    username = vars.userName;
    homeDirectory = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux "/home/${vars.userName}")
      (lib.mkIf pkgs.stdenv.isDarwin "/Users/${vars.userName}")
    ];
    stateVersion = "24.11";
    sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
      SOPS_AGE_KEY_FILE = "$HOME/.config/sops/age/keys.txt";
    };
  };

  stylix.targets = {
    waybar = {
      font = "sansSerif";
    };
    firefox = {
      firefoxGnomeTheme.enable = true;
      profileNames = [ "default" ];
    };
  };

  systemd.user.startServices = "sd-switch";

  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "application/x-extension-htm" = [ "firefox.desktop" ];
        "application/x-extension-html" = [ "firefox.desktop" ];
        "application/x-extension-shtml" = [ "firefox.desktop" ];
        "application/xhtml+xml" = [ "firefox.desktop" ];
        "application/x-extension-xhtml" = [ "firefox.desktop" ];
        "application/x-extension-xht" = [ "firefox.desktop" ];

        "application/zip" = [ "xarchiver.desktop" ];

        "image/svg+xml" = [ "org.inkscape.Inkscape.desktop" ];
        "image/gif" = [ "imv.desktop" ];
      };
    };
  };

  programs.home-manager.enable = true;

}
