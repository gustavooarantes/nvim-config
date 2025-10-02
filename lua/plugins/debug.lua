-- debug.lua
--
-- Supports Go, Python, C/C++, Rust, Java, and Elixir.
--

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
  },
  keys = {
    {
      "<leader>Dc",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Start/Continue",
    },
    {
      "<leader>Dsi",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step Into",
    },
    {
      "<leader>Dso",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step Over",
    },
    {
      "<leader>DsO",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step Out",
    },
    {
      "<leader>Db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<leader>DB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Debug: Set Breakpoint",
    },
    {
      "<leader>Dt",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: Toggle UI",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    ---------------------------
    -- Mason DAP Setup
    ---------------------------
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = { "delve", "python", "jdtls", "cppdbg", "codelldb", "elixir" },
    })

    ---------------------------
    -- DAP UI Setup (compatível com a nova API)
    ---------------------------
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      element_mappings = {
        stacks = { expand = "<CR>" },
        scopes = { expand = "<CR>" },
        breakpoints = { toggle = "t" },
      },
      expand_lines = true,
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
      force_buffers = true,
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 1.0 },
          },
          size = 0.25,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "rounded",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      render = {
        max_type_length = nil,
        indent = 2,
      },
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
      command = "OpenDebugAD7", -- mason instala automaticamente
    }

    dap.adapters.lldb = {
      type = "executable",
      command = "codelldb", -- Rust
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

    ---------------------------
    -- DAP UI Listeners
    ---------------------------
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
