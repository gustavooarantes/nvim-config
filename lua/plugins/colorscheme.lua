return {
  "EdenEast/nightfox.nvim",
  lazy = false,        -- load immediately
  priority = 1000,     -- load before other plugins
  opts = {
    options = {
      transparent = true,
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    vim.cmd("colorscheme carbonfox")
  end,
}
