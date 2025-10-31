-- lua/theme/colorscheme.lua
return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = false,
        terminal_colors = true,
      },
    })
    vim.cmd("colorscheme nightfox")
  end,
}
