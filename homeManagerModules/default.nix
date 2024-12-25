{...}: {
  imports = [
    ./terminal/sh.nix
    ./git.nix
    ./editors/emacs.nix
    ./editors/helix.nix
    ./terminal/kitty.nix
    ./terminal/utils.nix
    ./editors/nixvim.nix
    ./office.nix
    ./rclone.nix
    ./WM/hyprland/waybar.nix
    ./zotero.nix
    ./WM/hyprland/hypridle.nix
    ./WM/hyprland/hyprland.nix
    ./maestral.nix
    ./spicetify.nix
    ./qutebrowser.nix
    ./looking-glass.nix
    #    ./plasma-manager.nix
    ../stylix/stylix.nix
  ];
}
