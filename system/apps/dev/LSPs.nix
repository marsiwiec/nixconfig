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
      #lua
      lua-language-server
      #python
      pyright
      ruff
      python312Packages.jedi-language-server
      python312Packages.python-lsp-server
      #typst
      tinymist
      #rust
      rust-analyzer
      #other
      cmake-language-server
      arduino-language-server
    ];
  };
}
