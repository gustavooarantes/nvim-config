-- neotest.lua
---@diagnostic disable: missing-fields
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "rcasia/neotest-java", branch = "main" },
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-plenary",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        -- Java:
        require("neotest-java")({
          command = vim.fn.filereadable("gradlew") == 1 and "./gradlew" or "./mvnw",
          args = { "test" },
        }),
        -- Python
        require("neotest-python")({
          runner = "pytest",
          dap = { justMyCode = false },
        }),
        -- Go
        require("neotest-go")({
          experimental = { test_table = true },
        }),
        -- Rust:
        require("neotest-plenary")({
          command = "cargo",
          args = { "test" },
        }),
        -- C/C++:
        require("neotest-plenary")({
          command = "make",
          args = { "test" },
        }),
      },
      quickfix = { enabled = true, open = false },
    })
  end,
}
