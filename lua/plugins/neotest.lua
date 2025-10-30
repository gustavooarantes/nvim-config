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
					command = vim.fn.filereadable("gradlew") == 1 and "./gradlew" or "./mvnw",
					args = { "test" },
				}),
			},
		})
	end,
}
