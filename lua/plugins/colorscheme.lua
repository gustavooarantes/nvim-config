return {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {
    variant = "main", -- options: "auto", "main", "moon", "dawn"
    dark_variant = "main",
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false, -- this makes it transparent
    disable_float_background = true,
    disable_italics = false,
  },
  config = function(_, opts)
    require("rose-pine").setup(opts)
    vim.cmd("colorscheme rose-pine-main")
  end,
}
