{ nixvim, ... }:
{
  programs.nixvim = {
    enable = true;
    globalOpts = {  
      number = true;
      relativenumber = true;
      shiftwidth = 4;
      tabstop = 4;
      expandtab = true;
      smarttab = true;
      mouse = "a";
      clipboard = {
        providers = {
          wl-copy.enable = true;
        };
        register = "unnamedplus";
      };
      undofile = true;
      cursorline = true;
      ruler = true;
    };

    globals.mapleader = " ";

    keymaps = [
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
      }
    ];

  plugins = {
    lualine.enable = true;
    quarto.enable = true;
    nvim-autopairs.enable = true;
    telescope.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    luasnip.enable = true;
    bufferline.enable = true;
    web-devicons.enable = true;

    lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        bashls.enable = true;
        html.enable = true;
        cssls.enable = true;
        marksman.enable = true;
        nixd.enable = true;
        nil_ls.enable = true;
        pyright.enable = true;
        sqls.enable = true;
        tinymist.enable = true;
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
      };
      cmdline.mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = {
            action = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expandable() then
                  luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                elseif check_backspace() then
                  fallback()
                else
                  fallback()
                end
              end
            '';
            modes = [ "i" "s" ];
          };
        };
      };
    };
  };
}
