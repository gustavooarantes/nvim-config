return {
	"folke/tokyonight.nvim",
	name = "tokyonight",
	config = function()
		vim.o.background = "dark"
		vim.cmd("colorscheme tokyonight-night")
	end,
}
