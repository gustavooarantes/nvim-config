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

-- TELESCOPE: Find directories and cd (project aware)
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local lsp_util = require("lspconfig.util")

local function find_project_directories()
  local root = lsp_util.root_pattern(".git", "package.json", "pyproject.toml")(vim.fn.expand("%:p")) or vim.loop.cwd()

  local fd_cmd = vim.fn.executable("fd") == 1 and "fd" or "find"
  local cmd
  if fd_cmd == "fd" then
    cmd = { "fd", "--type", "d", "--hidden", "--follow", "--exclude", ".git", "--strip-cwd-prefix" }
  else
    cmd = { "find", ".", "-type", "d", "-not", "-path", "*/.git/*" }
  end

  pickers
    .new({}, {
      prompt_title = "Find directories",
      finder = finders.new_oneshot_job(cmd, { cwd = root }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)

          local dir = selection[1] or selection.value
          if dir == "." then
            dir = root
          end

          vim.cmd("cd " .. vim.fn.fnamemodify(dir, ":p"))
          print("cwd -> " .. vim.loop.cwd())
        end)
        return true
      end,
    })
    :find()
end

-- Map to <leader>fd
vim.keymap.set(
  "n",
  "<leader>fd",
  find_project_directories,
  { desc = "Telescope: Find directories (project root aware)" }
)
