{
  config,
  pkgs,
  lib,
  ...
}:

let
  fromGitHub =
    ref: repo:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };
in

{
  programs.neovim = {
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/init.lua};
    '';
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      catppuccin-nvim
      nord-nvim
      kanagawa-nvim
      plenary-nvim
      nvim-autopairs
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-buffer
      cmp-path
      cmp-calc
      cmp-emoji
      cmp_luasnip
      cmp-spell
      cmp-treesitter
      cmp-latex-symbols
      cmp-pandoc-references
      luasnip
      friendly-snippets
      lspkind-nvim
      otter-nvim
      neotest
      nvim-dap
      nvim-nio
      nvim-dap-ui
      nvim-dap-python
      nvim-dap-virtual-text
      bigfile-nvim
      nvim-surround
      comment-nvim
      tabular
      conform-nvim
      diffview-nvim
      neogit
      gitsigns-nvim
      git-conflict-nvim
      git-blame-nvim
      octo-nvim
      lazydev-nvim
      luvit-meta
      neoconf-nvim
      neorg
      mkdnflow-nvim
      obsidian-nvim
      quarto-nvim
      jupytext-nvim
      vim-slime
      img-clip-nvim
      nabla-nvim
      molten-nvim
      telescope-nvim
      todo-comments-nvim
      oil-nvim
      lualine-nvim
      tabby-nvim
      nvim-scrollview
      vim-illuminate
      nvim-tree-lua
      neo-tree-nvim
      which-key-nvim
      outline-nvim
      dropbar-nvim
      toggleterm-nvim
      trouble-nvim
      indent-blankline-nvim
      headlines-nvim
      image-nvim
      alpha-nvim
      nvim-web-devicons
      (fromGitHub "HEAD" "gnikdroy/projections.nvim")
    ];
  };
}
