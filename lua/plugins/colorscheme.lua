return {
  "EdenEast/nightfox.nvim",
  name = "carbonfox",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      palettes = {
        carbonfox = {
          -- Derived from your Monokai Classic palette
          bg0     = "#272822", -- base background (ignored due to black override)
          bg1     = "#1d1e19",
          bg2     = "#161613",
          fg0     = "#fdfff1", -- text
          fg1     = "#c0c1b5", -- slightly dimmed
          fg2     = "#919288", -- dimmed2
          sel0    = "#3b3c35", -- selection bg
          sel1    = "#57584f", -- alternate selection
          comment = "#6e7066", -- dimmed3

          -- Monokai Classic accents mapped to Nightfox semantic colors
          red     = "#f92672", -- accent1
          pink    = "#f92672",
          orange  = "#fd971f", -- accent2
          yellow  = "#e6db74", -- accent3
          green   = "#a6e22e", -- accent4
          cyan    = "#66d9ef", -- accent5
          blue    = "#66d9ef", -- same cyan tone (Monokai uses cyan for both)
          magenta = "#ae81ff", -- accent6
          white   = "#fdfff1",
          black   = "#000000",
        },
      },
      specs = {
        carbonfox = {
          syntax = {
            keyword     = "magenta", -- purple
            conditional = "magenta",
            number      = "orange",  -- orange
            constant    = "orange",
            string      = "yellow",  -- yellow
            func        = "green",   -- green
            statement   = "magenta",
            operator    = "pink",    -- red/pink
            preproc     = "cyan",    -- cyan
            type        = "blue",    -- cyanish blue
            variable    = "white",   -- text
            field       = "white",
            comment     = "comment", -- dim gray
          },
        },
      },
      options = {
        transparent = false,
        dim_inactive = false,
        styles = { all = "NONE" },
      },
    })

    -- Load Carbonfox
    vim.cmd("colorscheme carbonfox")
    vim.opt.background = "dark"

    -- Pitch-black UI overrides (intact)
    vim.defer_fn(function()
      local black = "#000000"

      vim.api.nvim_set_hl(0, "Normal", { bg = black })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = black })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = black })
      vim.api.nvim_set_hl(0, "VertSplit", { bg = black, fg = black })
      vim.api.nvim_set_hl(0, "LineNr", { bg = black })
      vim.api.nvim_set_hl(0, "CursorLineNr", { bg = black })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = black })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = black, fg = black })
      vim.api.nvim_set_hl(0, "Pmenu", { bg = black })
      vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#323232" })
    end, 0)
  end,
}
