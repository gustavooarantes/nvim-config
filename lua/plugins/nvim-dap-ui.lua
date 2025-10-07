-- nvim-dap-ui.lua
-- Debugging UI for Neovim (DAP)
return {
  "rcarriga/nvim-dap-ui",
  event = "VeryLazy",
  dependencies = {
    "mfussenegger/nvim-dap", -- Core DAP
    "nvim-neotest/nvim-nio", -- Optional testing integration
    "leoluz/nvim-dap-go", -- Go adapter
    "jay-babu/mason-nvim-dap.nvim", -- Auto-install DAP adapters
    "theHamsta/nvim-dap-virtual-text", -- Inline debug variables
    "nvim-telescope/telescope-dap.nvim",
  },
  opts = {
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "⏏",
        pause = "⏸",
        play = "▶",
        run_last = "▶▶",
        step_back = "b",
        step_into = "⏎",
        step_out = "⏮",
        step_over = "⏭",
        terminate = "⏹",
      },
    },
    element_mappings = {
      stacks = { expand = "<CR>" },
      scopes = { expand = "<CR>" },
      breakpoints = { toggle = "t" },
    },
    expand_lines = true,
    floating = {
      border = "rounded",
      mappings = { close = { "q", "<Esc>" } },
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "*",
      expanded = "",
    },
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
        elements = { "repl" },
        size = 0.25,
        position = "bottom",
      },
    },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t",
    },
    render = { indent = 2, max_type_length = nil },
  },
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup UI with opts
    dapui.setup(opts)

    -- Highlight and signs
    vim.api.nvim_set_hl(0, "DapStoppedHl", { fg = "#98BB6C", bg = "#2A2A2A", bold = true })
    vim.api.nvim_set_hl(0, "DapStoppedLineHl", { bg = "#204028", bold = true })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStoppedHl", linehl = "DapStoppedLineHl", numhl = "" })
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })

    -- Listeners
    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
