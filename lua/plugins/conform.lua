-- Return plugin specification for Lazy
return {
  "stevearc/conform.nvim",
  opts = {
    -- Define formatters by filetype
    formatters_by_ft = {
      -- Go: format code and organize imports
      go = { "gofumpt", "goimports" },

      -- Python: lint & format
      python = { "ruff" },

      -- Shell scripting: sh, bash, zsh
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      -- Dockerfile formatting
      dockerfile = { "prettier" },

      -- YAML / JSON / TOML formatting
      yaml = { "prettier" },
      json = { "prettier" },
      toml = { "taplo" },

      -- C / C++ / Objective-C formatting
      c = { "clang-format" },
      cpp = { "clang-format" },
      objc = { "clang-format" },

      -- Lua formatting
      lua = { "stylua" },
    },
  },
}
