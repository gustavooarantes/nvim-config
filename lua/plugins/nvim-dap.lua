-- dap.lua
-- Central configuration for Neovim DAP adapters and language setups

return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "leoluz/nvim-dap-go",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")

    ---------------------------
    -- Mason DAP Setup
    ---------------------------
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "delve", "python", "jdtls", "cppdbg", "codelldb", "elixir" },
    })

    ---------------------------
    -- Go
    ---------------------------
    require("dap-go").setup({
      delve = { detached = vim.fn.has("win32") == 0 },
    })

    ---------------------------
    -- Python
    ---------------------------
    dap.adapters.python = {
      type = "executable",
      command = "/usr/bin/python3", -- garante o Python correto
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          -- Detecta virtualenv local
          local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
          if vim.fn.filereadable(venv_path) == 1 then
            return venv_path
          end
          -- Fallback para Python global
          return "/usr/bin/python3"
        end,
      },
    }

    ---------------------------
    -- C/C++ and Rust
    ---------------------------
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "OpenDebugAD7", -- instalado pelo Mason
    }

    dap.adapters.lldb = {
      type = "executable",
      command = "codelldb",
      name = "lldb",
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
    }

    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    ---------------------------
    -- Elixir
    ---------------------------
    dap.adapters.mix_task = {
      type = "executable",
      command = "elixir-ls",
      args = {},
    }

    dap.configurations.elixir = {
      {
        type = "mix_task",
        request = "launch",
        name = "mix test",
        task = "test",
        projectDir = "${workspaceFolder}",
      },
    }
  end,
}
