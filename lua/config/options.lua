-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- TAB / INDENT CONFIG
vim.opt.expandtab = true -- usa tabs reais (\t)
vim.opt.tabstop = 2 -- 1 tab = 4 espaços visualmente
vim.opt.shiftwidth = 2 -- auto-indent = 4
vim.opt.softtabstop = 2 -- Tab no insert = 4
vim.opt.shiftround = true -- arredonda indent automático
vim.opt.autoindent = true -- herda indent da linha acima
vim.opt.smartindent = true -- indent inteligente pra código
vim.opt.termguicolors = true

-- SCROLLING
vim.opt.scrolloff = 10 -- 10 linhas visíveis acima/abaixo do cursor
