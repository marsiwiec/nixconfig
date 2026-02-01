{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
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
