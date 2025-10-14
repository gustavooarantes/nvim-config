return {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      variant = "main",
      dark_variant = "main",
      styles = { bold = true, italic = true, transparency = true },
      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",
        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",
      },
    })
    vim.cmd("colorscheme rose-pine-main")
  end,
}
