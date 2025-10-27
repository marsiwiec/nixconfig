{
  lib,
  pkgs,
  vars,
  inputs,
  ...
}:
{
  imports = [
    inputs.stylix.homeManagerModules.stylix
    inputs.niri.homeModules.niri
    inputs.niri.homeModules.stylix

    ./browsers
    ./cloud
    ./desktop
    ./editors
    ./graphics
    ./media
    ./nixgroot
    ./office
    ./terminal
    ../../style/stylix
    ../../style/stylix/home
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

  systemd.user.startServices = "sd-switch";
}
