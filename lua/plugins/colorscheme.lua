return {
	"nyoom-engineering/oxocarbon.nvim",
	name = "oxocarbon",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.background = "dark"
		vim.cmd("colorscheme oxocarbon")

		-- Apply pitch-black background globally
		vim.defer_fn(function()
			local black = "#000000"

			-- Adjusting the selection background in completion menus
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#373737" })

			-- Core windows
			vim.api.nvim_set_hl(0, "Normal", { bg = black })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = black })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = black })
			vim.api.nvim_set_hl(0, "VertSplit", { bg = black, fg = black })
			vim.api.nvim_set_hl(0, "LineNr", { bg = black })
			vim.api.nvim_set_hl(0, "CursorLineNr", { bg = black })

			-- Floating windows / popups
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = black })
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = black, fg = black })
			vim.api.nvim_set_hl(0, "Pmenu", { bg = black })
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = black })
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = black })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = black, fg = black })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = black })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = black, fg = black })
			vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = black })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = black, fg = black })
			vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = black })
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = black, fg = black })
		end, 0)
	end,
}
