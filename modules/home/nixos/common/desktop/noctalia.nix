{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  options = {
    noctalia.enable = lib.mkEnableOption "enable noctalia-shell";
  };

  config = lib.mkIf config.noctalia.enable {
    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
    };
  };
}
