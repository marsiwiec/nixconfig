{
  pkgs,
  inputs,
  ...
}: {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      wl-clipboard
    ];
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ../../config/neovim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      neodev-nvim

      nvim-autopairs

      nvim-cmp
      {
        plugin = nvim-cmp;
        config = toLuaFile ../../config/neovim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ../../config/neovim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      lualine-nvim
      nvim-web-devicons

      {
        plugin = nvim-treesitter.withAllGrammars;
        config = toLuaFile ../../config/neovim/plugin/treesitter.lua;
      }

      vim-nix
    ];
    extraLuaConfig = ''
      ${builtins.readFile ../../config/neovim/options.lua}
    '';
  };
}
