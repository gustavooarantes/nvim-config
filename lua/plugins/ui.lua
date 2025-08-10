-- ~/.config/nvim/lua/plugins/ui.lua
return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = {
        "██████  ██       █████   ██████ ██   ██ ███████ ██ ████████ ███████ ",
        "██   ██ ██      ██   ██ ██      ██  ██  ██      ██    ██    ██      ",
        "██████  ██      ███████ ██      █████   ███████ ██    ██    █████   ",
        "██   ██ ██      ██   ██ ██      ██  ██       ██ ██    ██    ██      ",
        "██████  ███████ ██   ██  ██████ ██   ██ ███████ ██    ██    ███████ ",
      }
      -- calcula quantas linhas vazias pra centralizar verticalmente
      local padding = math.max(0, math.floor((vim.o.lines - #logo) / 2) - 7)
      for _ = 1, padding do
        table.insert(logo, 1, "")
      end

      opts.config = opts.config or {}
      opts.config.header = logo
      return opts
    end,
  },
}
