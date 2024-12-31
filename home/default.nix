{lib, ...}: {
  imports = [
    ./browsers
    ./editors
    ./office
    ./terminal
    ./wm
    ./git.nix
    ./rclone.nix
    ./zotero.nix
    ./maestral.nix
    ./spicetify.nix
    ./looking-glass.nix
    ../stylix/stylix.nix
  ];
  git.enable = lib.mkDefault true;
  rclone.enable = lib.mkDefault true;
  zotero.enable = lib.mkDefault true;
  maestral.enable = lib.mkDefault true;
  spicetify.enable = lib.mkDefault true;
  looking-glass.enable = lib.mkDefault true;
}
