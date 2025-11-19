return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          on_init = function(client)
            local function find_venv()
              local cwd = vim.fn.getcwd()
              local patterns = {
                ".venv/bin/python",
                "venv/bin/python",
                "env/bin/python",
                ".env/bin/python",
              }

              for _, rel in ipairs(patterns) do
                local abs = cwd .. "/" .. rel
                if vim.fn.filereadable(abs) == 1 then
                  return abs
                end
              end

              local path = cwd
              while path ~= "/" do
                for _, rel in ipairs(patterns) do
                  local abs = path .. "/" .. rel
                  if vim.fn.filereadable(abs) == 1 then
                    return abs
                  end
                end
                path = vim.fn.fnamemodify(path, ":h")
              end

              return vim.fn.exepath("python3") or vim.fn.exepath("python")
            end

            local python_path = find_venv()
            if python_path then
              client.config.settings = client.config.settings or {}
              client.config.settings.python = client.config.settings.python or {}
              client.config.settings.python.pythonPath = python_path
            end
          end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
              },
            },
          },
        },
      },
    },
  },
}
