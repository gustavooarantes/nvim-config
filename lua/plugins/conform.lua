return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			my_clang_format = {
				command = "clang-format",
				args = {
					'--style={BasedOnStyle: "LLVM", IndentWidth: 2, BreakBeforeBraces: "Attach", AllowShortFunctionsOnASingleLine: "Empty", ColumnLimit: 100}',
				},
			},

			my_prettier = {
				command = "prettier",
				args = {
					"--print-width",
					"80",
					"--tab-width",
					"2",
					"--use-tabs",
					"false",
					"--semi",
					"true",
					"--single-quote",
					"false",
					"--trailing-comma",
					"es5",
				},
			},

			my_ruff = {
				command = "ruff",
				args = { "format", "--line-length", "88" },
			},

			my_shfmt = {
				command = "shfmt",
				args = { "-i", "2" },
			},
		},

		formatters_by_ft = {
			go = { "gofumpt", "goimports" },
			dockerfile = { "dockerls" },
			toml = { "taplo" },

			python = { "my_ruff" },
			sh = { "my_shfmt" },
			bash = { "my_shfmt" },
			zsh = { "my_shfmt" },
			c = { "my_clang_format" },
			cpp = { "my_clang_format" },
			lua = { "my_stylua" },
			html = { "my_prettier" },
			css = { "my_prettier" },
			javascript = { "my_prettier" },
			typescript = { "my_prettier" },
			json = { "my_prettier" },
			yaml = { "my_prettier" },
		},
	},
}
