return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      hidden = true,
      ignored = true,
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
        explorer = {
          layout = {
            preset = "sidebar",
            preview = false,
            layout = {
              position = "right",
            },
          },
          cycle = true,
          auto_close = true,
        },
      },
    },
  },
}
