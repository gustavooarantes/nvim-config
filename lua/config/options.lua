-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Better colors
vim.opt.termguicolors = true

-- Disable swaps and other useless stuff nowadays
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Disable the mouse while in nvim
vim.opt.mouse = ""

-- Line Numbers
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 4

-- TAB / INDENT CONFIG
vim.opt.expandtab = true   -- uses spaces instead of \t
vim.opt.tabstop = 2        -- 1 tab = 2 spaces visually
vim.opt.shiftwidth = 2     -- auto-indent = 2
vim.opt.softtabstop = 2    -- Tab on insert = 2
vim.opt.shiftround = true  -- automatically rounds indent
vim.opt.autoindent = true  -- inherits from above line
vim.opt.smartindent = true -- smart indent

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- SCROLLING
vim.opt.scrolloff = 10 -- 10 always visible lines above/below the cursor

-- Cursor Line
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.guicursor = table.concat({
  "n-v-c:block",
  "i-ci:block-blinkwait175-blinkon150-blinkoff175",
  "r-cr:hor20",
  "o:hor50",
  "sm:block-blinkwait175-blinkon150-blinkoff175"
}, ",")

-- Folding
vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds

-- Better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Always show the sign column to avoid text shifting
vim.opt.signcolumn = "yes"

-- Faster updates for LSP, CursorHold, etc.
vim.opt.updatetime = 300

-- Highlight matching brackets instantly
vim.opt.showmatch = true
