{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
  ];
  programs.nixvim = {
    enable = true;
    opts = {
      number = true;

      relativenumber = true;
      shiftwidth = 2;
      expandtab = true;
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
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              local function on_format(err)
                if err and err:match("timeout$") then
                  slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
              end

              return { timeout_ms = 200, lsp_fallback = true }, on_format
             end
          '';
        };
      };
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
          nixd = {
            enable = true;
            settings = {
              formatting.command = [
                "alejandra"
              ];
            };
          };
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
            modes = ["i" "s"];
          };
        };
      };
    };
  };
}
