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
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
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
      command = "OpenDebugAD7", -- installed by Mason
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
    -- Java
    ---------------------------
    dap.adapters.java = function(callback)
      callback({
        type = "server",
        host = "127.0.0.1",
        port = 5005,
      })
    end

    dap.configurations.java = {
      {
        type = "java",
        request = "launch",
        name = "Launch Java Program",
        mainClass = function()
          return vim.fn.input("Main class > ")
        end,
        projectName = function()
          return vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        end,
      },
    }

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
