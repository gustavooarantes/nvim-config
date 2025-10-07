-- LSP Support
return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    { "mason-org/mason.nvim" },
    { "mason-org/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    { "j-hui/fidget.nvim", opts = {} },
  },

  config = function()
    ------------------------------------------------------------------------
    -- Mason setup
    ------------------------------------------------------------------------
    require("mason").setup()

    ------------------------------------------------------------------------
    -- LSP servers installation and configuration
    ------------------------------------------------------------------------
    local lspconfig = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lsp_attach = function(client, bufnr)
      -- your keybindings / custom buffer-local setup here
    end

    require("mason-lspconfig").setup({
      ensure_installed = {
        "ansiblels",
        "bashls",
        "clangd",
        "docker_compose_language_service",
        "dockerls",
        "elixirls",
        "gopls",
        "jdtls",
        "jsonls",
        "lua_ls",
        "marksman",
        "neocmake",
        "pyright",
        "rust_analyzer",
        "terraformls",
        "vtsls",
        "yamlls",
        "lemminx",
        "html",
        "cssls",
        "quick_lint_js",
        "groovyls",
        "gradle_ls",
      },

      --------------------------------------------------------------------
      -- 🧠 Modern API: use 'handlers' instead of setup_handlers()
      --------------------------------------------------------------------
      handlers = {
        function(server_name)
          -- Skip JDTLS (it's configured separately)
          if server_name ~= "jdtls" then
            lspconfig[server_name].setup({
              on_attach = lsp_attach,
              capabilities = lsp_capabilities,
            })
          end
        end,
      },
    })

    ------------------------------------------------------------------------
    -- Mason tools installer (linters / formatters / debuggers)
    ------------------------------------------------------------------------
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Linters
        "ansible-lint",
        "cmakelint",
        "erb-lint",
        "hadolint",
        "shellcheck",
        "sqlfluff",
        "tflint",
        "ruff",
        "markdownlint-cli2",

        -- Formatters
        "clang-format",
        "gofumpt",
        "goimports",
        "prettier",
        "shfmt",
        "stylua",

        -- Debuggers
        "codelldb",
        "cpptools",
        "debugpy",
        "delve",
        "java-debug-adapter",
        "java-test",
        "js-debug-adapter",

        -- Other tools
        "taplo",
        "tree-sitter-cli",
        "markdown-toc",
      },
    })

    -- Workaround: force MasonToolsInstall on lazy load
    vim.api.nvim_command("MasonToolsInstall")

    ------------------------------------------------------------------------
    -- Lua LSP: special configuration
    ------------------------------------------------------------------------
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    ------------------------------------------------------------------------
    -- Global floating window style
    ------------------------------------------------------------------------
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded"
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
