local dap = require('dap')
local dapui = require('dapui')
local dap_virtual_text = require('nvim-dap-virtual-text')

-- DAP UI
dapui.setup()
dap_virtual_text.setup()

-- Automatically open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- Keymaps
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<Leader>dB', function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

-- Python
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = "${file}",
    pythonPath = function()
      return '/usr/bin/python3'
    end,
  },
}

-- Go (requires delve)
dap.adapters.go = function(callback)
  local handle
  local port = 38697
  handle = vim.loop.spawn("dlv", {
    args = {"dap", "-l", "127.0.0.1:" .. port},
    detached = true,
  }, function(code) handle:close() end)
  vim.defer_fn(function() callback({type = "server", host = "127.0.0.1", port = port}) end, 100)
end
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}"
  }
}

-- C/C++ (requires codelldb)
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "codelldb",
    args = {"--port", "${port}"},
  }
}
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
dap.configurations.c = dap.configurations.cpp

-- Java (requires nvim-jdtls + vscode-java-debug)
dap.configurations.java = {
  {
    type = 'java',
    request = 'launch',
    name = "Launch Java",
  }
}
