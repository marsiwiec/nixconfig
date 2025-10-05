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
      #nix
      nil
      nixd
      #markdown
      marksman
      markdown-oxide
      harper
      mpls
      #lua
      lua-language-server
      #python
      pyright
      ruff
      #typst
      tinymist
      #rust
      rust-analyzer
      #r
      air-formatter
    ];
  };
}
