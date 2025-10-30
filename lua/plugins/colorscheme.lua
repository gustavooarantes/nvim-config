return {
	"EdenEast/nightfox.nvim",
	name = "carbonfox",
	lazy = false,
	priority = 1000,
	config = function()
		require("nightfox").setup({
			options = {
				transparent = false, -- solid background
				dim_inactive = false, -- keep all windows same brightness
				styles = { all = "NONE" },
			},
		})

		-- Load Carbonfox first
		vim.cmd("colorscheme carbonfox")
		vim.opt.background = "dark"

		-- Apply pitch-black background globally
		vim.defer_fn(function()
			local black = "#000000"
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
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#323232" })
		end, 0)
	end,
}
