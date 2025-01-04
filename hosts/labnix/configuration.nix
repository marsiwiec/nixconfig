{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../system
  ];

  #### My own modules ####
  gaming.enable = false;
  sddm.enable = true;
  greetd.enable = false;

  stylix = lib.mkForce {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  };

  networking.hostName = "labnix"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
