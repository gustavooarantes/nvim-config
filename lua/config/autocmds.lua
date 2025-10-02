-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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
    -- Se o disable_autoformat for true, saia
    if vim.b.disable_autoformat then
      return
    end

    -- Use o utilitário de formatação da LazyVim, que já sabe como lidar com o conform
    require("lazyvim.util.format").format()
  end,
})
