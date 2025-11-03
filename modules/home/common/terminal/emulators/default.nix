{ lib, ... }:
{
  imports = [
    ./foot.nix
    ./ghostty.nix
    ./kitty.nix
    ./wezterm.nix
  ];
  # foot_term.enable = lib.mkDefault true;
  # ghostty.enable = lib.mkDefault true;
  # kitty.enable = lib.mkDefault true;
  wezterm.enable = lib.mkDefault true;
}
