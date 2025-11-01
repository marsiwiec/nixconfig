{
  lib,
  config,
  pkgs,
  ...
}:
{

  options = {
    ollama.enable = lib.mkEnableOption "config for ollama";
  };

  config = lib.mkIf config.ollama.enable {
    environment.systemPackages = with pkgs; [
      ollama-cuda
    ];
  };
}
