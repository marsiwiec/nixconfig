{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    localsend.enable = lib.mkEnableOption "localsend p2p file transfer";
  };
  config = lib.mkIf config.localsend.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
