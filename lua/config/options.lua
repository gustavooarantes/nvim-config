-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Configs for converting tabs to spaces and setting it to a 4 spaces size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Config for keeping 10 lines visible around the cursor
vim.opt.scrolloff = 10

-- Disable format-on-save globally
vim.g.autoformat = false
