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

-- TELESCOPE
local builtin = require("telescope.builtin")

-- Live grep in current buffer
vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Search in current buffer" })

-- Other pickers
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

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
