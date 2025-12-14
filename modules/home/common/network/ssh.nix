{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.ssh.enable = lib.mkEnableOption "enable ssh";
  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
    };
    services.ssh-agent.enable = true;
  };

}
