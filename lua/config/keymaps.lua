-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Disable arrow keys in insert mode
vim.keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Disable arrow keys in visual mode
vim.keymap.set("v", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Right>", "<Nop>", { noremap = true, silent = true })

-- Center current line when scolling with Ctrl + D or Ctrl + U
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Center the cursor when navigating search results
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- Split window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
vim.keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
vim.keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
vim.keymap.set("n", "<leader>s>", "<C-w>>5") -- make split windows width bigger
vim.keymap.set("n", "<leader>s<", "<C-w><5") -- make split windows width smaller

-- Quickfix keymaps
vim.keymap.set("n", "<leader>qo", ":copen<CR>") -- open quickfix list
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
vim.keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
vim.keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
vim.keymap.set("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
vim.keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list
vim.keymap.set("n", "]q", ":cnext<CR>zz", { silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>zz", { silent = true })

-- TELESCOPE
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, {}) -- fuzzy find files in project
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, {}) -- grep file contents in project
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, {}) -- fuzzy find open buffers
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, {}) -- fuzzy find help tags
vim.keymap.set("n", "<leader>fs", require("telescope.builtin").current_buffer_fuzzy_find, {}) -- fuzzy find in current file buffer
vim.keymap.set("n", "<leader>fo", require("telescope.builtin").lsp_document_symbols, {}) -- fuzzy find LSP/class symbols
vim.keymap.set("n", "<leader>fi", require("telescope.builtin").lsp_incoming_calls, {}) -- fuzzy find LSP/incoming calls

-- Code Action (normal mode)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "LSP: Code Action" })

-- JDT Restart
vim.keymap.set(
  "n",
  "<leader>jr",
  ":JdtRestart<CR>",
  { noremap = true, silent = true, desc = "JDT: Restart Language Server" }
)

-- Recent Projects
vim.keymap.set("n", "<leader>fp", function()
  require("telescope").extensions.projects.projects()
end, { noremap = true, silent = true, desc = "Telescope: Projects" })

-- Rename class/method/variable or anything in the whole project (yeah suck it IntelliJ)
vim.keymap.set("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Rename symbol via LSP" })

-- DEBUG / DAP KEYMAPS
local dap = require("dap")
local dapui = require("dapui")
local map_opts = { noremap = true, silent = true }

-- Start/Continue
vim.keymap.set("n", "<leader>Dc", function()
  dap.continue()
end, map_opts)
-- Step Into
vim.keymap.set("n", "<leader>Dsi", function()
  dap.step_into()
end, map_opts)
-- Step Over
vim.keymap.set("n", "<leader>Dso", function()
  dap.step_over()
end, map_opts)
-- Step Out
vim.keymap.set("n", "<leader>DsO", function()
  dap.step_out()
end, map_opts)
-- Toggle Breakpoint
vim.keymap.set("n", "<leader>Db", function()
  dap.toggle_breakpoint()
end, map_opts)
-- Set Conditional Breakpoint
vim.keymap.set("n", "<leader>DB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, map_opts)
-- Toggle DAP UI
vim.keymap.set("n", "<leader>Dt", function()
  dapui.toggle()
end, map_opts)

-- LSP
vim.keymap.set("n", "<leader>gg", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.keymap.set("n", "<leader>rr", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
vim.keymap.set("v", "<leader>gf", "<cmd>lua vim.lsp.buf.format({async = true})<CR>")
vim.keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<leader>gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "<leader>gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "<leader>gn", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "<leader>tr", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
vim.keymap.set("i", "<C-Space>", "<cmd>lua vim.lsp.buf.completion()<CR>")
