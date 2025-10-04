-- Return plugin specification for Lazy
return {
  "hrsh7th/nvim-cmp", -- Main completion plugin
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
    "hrsh7th/cmp-path", -- Path source for nvim-cmp
    "L3MON4D3/LuaSnip", -- Snippet engine
    "rafamadriz/friendly-snippets", -- Predefined snippets collection
    "saadparwaiz1/cmp_luasnip", -- LuaSnip source for nvim-cmp
  },
  config = function()
    -- Load modules
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load friendly snippets from VSCode collection
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Setup nvim-cmp
    cmp.setup({
      -- Snippet expansion
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Expand snippet using LuaSnip
        end,
      },
      -- Key mappings for completion menu
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection

        -- Tab navigation for completion/snippets
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item() -- Select next item in completion menu
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump() -- Expand or jump in snippet
          else
            fallback() -- Default fallback behavior
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item() -- Select previous item in completion menu
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1) -- Jump backwards in snippet
          else
            fallback() -- Default fallback behavior
          end
        end, { "i", "s" }),

        ["<Esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort() -- Fecha o menu de completions
          else
            fallback() -- Deixa o ESC normal funcionar
          end
        end, { "i", "s" }),
      },

      -- Completion sources
      sources = {
        { name = "nvim_lsp" }, -- LSP completions
        { name = "luasnip" }, -- Snippet completions
        { name = "buffer" }, -- Buffer completions
        { name = "path" }, -- File path completions
      },
    })
  end,
}
