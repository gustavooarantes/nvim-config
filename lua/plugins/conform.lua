return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Java
      java = { "google-java-format" },

      -- Kotlin
      kotlin = { "ktlint" },

      -- Go
      go = { "gofumpt", "goimports" },

      -- PHP
      php = { "php-cs-fixer" },

      -- Python
      python = { "ruff" },

      -- Ruby
      ruby = { "rubocop" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      -- Docker
      dockerfile = { "prettier" },

      -- YAML / JSON / TOML
      yaml = { "prettier" },
      json = { "prettier" },
      toml = { "taplo" },

      -- C / C++ / ObjC
      c = { "clang-format" },
      cpp = { "clang-format" },
      objc = { "clang-format" },

      -- Lua
      lua = { "stylua" },
    },
    formatters = {
      ["php-cs-fixer"] = {
        command = "php-cs-fixer",
        args = { "fix", "--quiet", "$FILENAME" },
        stdin = false, -- php-cs-fixer works in place
      },
    },
  },
}
