{
  lib,
  config,
  pkgs,
  vars,
  ...
}:
{
  options = {
    nh.enable = lib.mkEnableOption "nh nix helper";
  };
  config = lib.mkIf config.nh.enable {
    programs.nh = {
      enable = true;
      flake = "${config.users.defaultUserHome}/nixconfig";
    };
    environment.shellAliases = {
      update = "nh os switch --ask";
    };
  };
}
