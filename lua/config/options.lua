-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable the mouse while in nvim
vim.opt.mouse = ""

-- Line Numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- TAB / INDENT CONFIG
vim.opt.expandtab = false -- uses true tabs (\t)
vim.opt.tabstop = 2 -- 1 tab = 4 spaces visually
vim.opt.shiftwidth = 2 -- auto-indent = 4
vim.opt.softtabstop = 2 -- Tab on insert = 4
vim.opt.shiftround = true -- automatically rounds indent
vim.opt.autoindent = true -- inherits from above line
vim.opt.smartindent = true -- smart indent

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- SCROLLING
vim.opt.scrolloff = 7 -- 7 always visible lines above/below the cursor

-- Cursor Line
vim.opt.cursorline = true

-- Folding
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds
