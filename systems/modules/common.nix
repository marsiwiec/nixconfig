{...}: {
  imports = [
    ./firefox.nix
    #./R.nix
    ./python.nix
    ./utils.nix
    ./virtualisation.nix
    ./vfio.nix
    ./avahi.nix
    ./tailscale.nix
    ./gc.nix
    ./hyprland.nix
    ./lan-mouse.nix
    ./nvidia-enable.nix
    ./plasma6.nix
    ../../stylix/stylix.nix
    ./thunar.nix
  ];
}
