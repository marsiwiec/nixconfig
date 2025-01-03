{ pkgs, ... }:
{
  imports = [
    ./home
  ];

  home.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    intel-one-mono
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
