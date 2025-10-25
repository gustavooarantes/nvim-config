-- lua/plugins/colorscheme.lua
return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false,
			undercurl = true,
			commentStyle = { italic = true },
			functionStyle = { bold = true },
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = { bold = true },
			transparent = false,
			dimInactive = false,
			terminalColors = true,

			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus",
			},

			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},

			overrides = function(colors)
				local theme = colors.theme
				return {
					CursorLine = { bg = theme.ui.bg_p2 },
					LineNr = { fg = theme.ui.nontext },
					CursorLineNr = { fg = theme.diag.hint },
					Comment = { fg = theme.ui.special, italic = true },
					DiagnosticVirtualTextError = { bg = "none" },
					DiagnosticVirtualTextWarn = { bg = "none" },
					DiagnosticVirtualTextInfo = { bg = "none" },
					DiagnosticVirtualTextHint = { bg = "none" },

					-- INÍCIO: OVERRIDES PARA LUALINE E NAVIC
					LualineNormal = { bg = theme.ui.bg_p1 },
					LualineA = { bg = theme.ui.bg_p1, fg = theme.syn.special, bold = true },
					LualineB = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
					LualineC = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
					LualineX = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
					LualineY = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
					LualineZ = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
					LualineSeparator = { fg = theme.ui.bg_p1, bg = "none" },
					LualineInactiveSeparator = { fg = theme.ui.bg_m3, bg = "none" },

					NavicText = { bg = "none", fg = theme.ui.fg },
					NavicIcons = { bg = "none" },
					NavicSeparator = { bg = "none" },

					StatusLine = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
					StatusLineNC = { bg = theme.ui.bg_m3, fg = theme.ui.nontext },
					-- FIM: OVERRIDES PARA LUALINE E NAVIC
				}
			end,
		})

		vim.cmd("colorscheme kanagawa-wave")
	end,
}
