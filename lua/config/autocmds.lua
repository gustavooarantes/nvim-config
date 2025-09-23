-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Enable relative numbers in netrw
vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.opt_local.number = true -- enable absolute line numbers
    vim.opt_local.relativenumber = true -- enable relative numbers
  end,
})

-- Desabilita formatação automática dentro de ~/Supera e subdiretórios
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function()
    local path = vim.fn.expand("%:p") -- caminho absoluto do arquivo atual
    local supera_path = vim.fn.expand("~") .. "/Supera/"
    if path:sub(1, #supera_path) == supera_path then
      vim.b.disable_autoformat = true
    else
      vim.b.disable_autoformat = false
    end
  end,
})

-- Autocmd que formata no save (mas respeita o disable_autoformat)
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.b.disable_autoformat then
      return
    end
    -- aqui chama o conform pra formatar o buffer
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ async = true })
    end
  end,
})
