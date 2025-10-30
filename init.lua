require("config.lazy")

-- Open netrw at startup if no files were passed
if vim.fn.argc() == 0 then
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			-- Open netrw
			vim.cmd("Explore")
			-- Immediately set relative numbers in the new netrw buffer
			vim.wo.number = true
			vim.wo.relativenumber = true
		end,
	})
end
