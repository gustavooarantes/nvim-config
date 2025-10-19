return {
  "folke/tokyonight.nvim",
  name = "tokyonight",
  config = function()
    vim.o.background = "dark"
    vim.g.tokyonight_style = "night"
    vim.cmd("colorscheme tokyonight-night")
  end,
}
