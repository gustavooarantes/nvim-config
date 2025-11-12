-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    local path = vim.fn.expand("%:p")
    local supera_path = vim.fn.expand("~") .. "/Supera/"
    if path:sub(1, #supera_path) == supera_path then
      vim.b.disable_autoformat = true
    else
      vim.b.disable_autoformat = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.b.disable_autoformat then
      return
    end

    require("lazyvim.util.format").format()
  end,
})
