-- neotest.lua
---@diagnostic disable: missing-fields
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "rcasia/neotest-java", branch = "main" },
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-java")({
          command = "./mvnw", -- Use "./gradlew" if using Gradle
          args = { "test" },
        }),
      },
    })
  end,
}
