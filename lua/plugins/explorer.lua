-- Disabling Snacks explorer and dashboard
return {
	"folke/snacks.nvim",
	opts = {
		explorer = { enabled = false },
	},
	config = function()
		-- Toggle netrw function
		local function toggle_netrw()
			local netrw_buf = nil
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].filetype == "netrw" and vim.api.nvim_buf_is_loaded(buf) then
					netrw_buf = buf
					break
				end
			end

			if netrw_buf and vim.api.nvim_buf_is_valid(netrw_buf) then
				vim.api.nvim_buf_delete(netrw_buf, { force = true })
			else
				vim.cmd.Ex()
			end
		end

		-- Map leader+e to toggle netrw
		vim.keymap.set("n", "<leader>e", toggle_netrw, { desc = "Toggle netrw", silent = true })

		-- Enable numbers for netrw buffers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "netrw",
			callback = function()
				vim.opt_local.number = true
				vim.opt_local.relativenumber = true
			end,
		})

		-- Open netrw if Vim starts on a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				local f = vim.fn.expand("<afile>")
				if vim.fn.isdirectory(f) == 1 then
					vim.cmd.Lexplore()
				end
			end,
		})
	end,
}
