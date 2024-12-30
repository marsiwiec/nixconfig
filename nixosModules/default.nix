{...}: {
  imports = [
    ./ollama.nix
    ./avahi.nix
    ./firefox.nix
    #    ./gaming.nix
    ./gc.nix
    ./hyprland.nix
    # ./lan-mouse.nix
    ./nvidia-enable.nix
    # ./plasma6.nix
    ./python.nix
    # ./R.nix
    ./tailscale.nix
    ./thunar.nix
    ./utils.nix
    ./vfio.nix
    ./virtualisation.nix
    ../stylix/stylix.nix
  ];
}
