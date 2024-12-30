{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    shells.enable = lib.mkEnableOption "defauls zsh config";
  };
  config = lib.mkIf config.shells.enable {
    environment.shells = with pkgs; [zsh];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;
  };
}
