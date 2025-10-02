return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local db = require("dashboard")
    db.setup({
      theme = "doom",
      config = {
        header = {
          "         ,_---~~~~~----._         ",
          '  _,,_,*^____      _____``*g*\\"*, ',
          " / __/ /'     ^.  /      \\ ^@q   f ",
          "[  @f | @))    |  | @))   l  0 _/  ",
          " \\`/   \\~____ / __ \\_____/    \\   ",
          "  |           _l__l_           I   ",
          "  }          [______]           I  ",
          "  ]            | | |            |  ",
          "  ]             ~ ~             |  ",
          "  |                            |   ",
          "   |                           |   ",
          "",
        },
        center = {
          {
            icon = " ",
            desc = " Find File",
            key = "f",
            action = "Telescope find_files",
            key_hl = "Number",
            desc_hl = "String",
          },
          {
            icon = " ",
            desc = " Recent Files",
            key = "r",
            action = "Telescope oldfiles",
            key_hl = "Number",
            desc_hl = "String",
          },
          {
            icon = " ",
            desc = " Config",
            key = "c",
            action = function()
              require("telescope.builtin").find_files({
                prompt_title = "< NVIM CONFIG >",
                cwd = vim.fn.stdpath("config"),
              })
            end,
            key_hl = "Number",
            desc_hl = "String",
          },
          {
            icon = "📦",
            desc = " Lazy",
            key = "l",
            action = "Lazy",
            key_hl = "Number",
            desc_hl = "String",
          },
        },
        footer = { "Happy coding!" },
        vertical_center = true,
      },
    })
  end,
}
