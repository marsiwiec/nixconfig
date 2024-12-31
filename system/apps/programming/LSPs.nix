{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    LSPs.enable = lib.mkEnableOption "Various LSPs";
  };

  config = lib.mkIf config.LSPs.enable {
    environment.systemPackages = with pkgs; [
      nil
      nixd
      lua-language-server
      pyright
      rust-analyzer
      cmake-language-server
      arduino-language-server
    ];
  };
}
