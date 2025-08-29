-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Open netrw at startup if no files were passed
if vim.fn.argc() == 0 then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- Open netrw
      vim.cmd("Explore")
      
      -- Immediately set relative numbers in the new netrw buffer
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_option(bufnr, "number", true)
      vim.api.nvim_buf_set_option(bufnr, "relativenumber", true)
    end,
  })
end
