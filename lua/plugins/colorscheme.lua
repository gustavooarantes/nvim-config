return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      transparent = true,
      on_colors = function(_) end,
      on_highlights = function(_, _) end,
    })
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
