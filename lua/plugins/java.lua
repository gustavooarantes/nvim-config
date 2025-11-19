-- plugins/java.lua
local home = vim.env.HOME

return {
  {
    "mfussenegger/nvim-jdtls",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local ok, jdtls = pcall(require, "jdtls")
      if not ok then
        vim.notify("nvim-jdtls não instalado", vim.log.levels.WARN)
        return
      end

      local function get_workspace()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        return home .. "/jdtls-workspace/" .. project_name
      end

      local function get_bundles()
        local bundles = {}
        local debug_jar =
          vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar")
        if debug_jar ~= "" then
          table.insert(bundles, debug_jar)
        end
        local test_jars = vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n")
        for _, j in ipairs(test_jars) do
          if j ~= "" then
            table.insert(bundles, j)
          end
        end
        return bundles
      end

      local system_os = (vim.fn.has("mac") == 1 and "mac") or (vim.fn.has("win32") == 1 and "win") or "linux"

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok and cmp and cmp.default_capabilities then
        capabilities = cmp.default_capabilities()
      end

      local function start_jdtls()
        local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" })
        if not root_dir then
          root_dir = vim.fn.getcwd()
          vim.notify("JDTLS: root não encontrado, usando cwd", vim.log.levels.WARN)
        end

        local workspace_dir = get_workspace()

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
            "-Xmx4g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            home .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
            "-configuration",
            home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. system_os,
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
          settings = {
            java = {
              home = "/usr/lib/jvm/java-17-openjdk",
              eclipse = { downloadSources = true },
              import = {
                maven = { enabled = true, downloadSources = true, downloadJavadoc = true },
                gradle = { enabled = true, downloadSources = true, downloadJavadoc = true },
              },
              configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                  { name = "JavaSE-1.8", path = "/usr/lib/jvm/java-8-openjdk" },
                  { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk" },
                  { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
                  { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk" },
                },
              },
              format = {
                enabled = true,
                settings = {
                  url = home .. "/.local/share/nvim/mason/share/google-java-format/google-style.xml",
                  profile = "GoogleStyle",
                },
              },
              completion = { favoriteStaticMembers = {} },
              contentProvider = { preferred = "fernflower" },
            },
          },
          capabilities = capabilities,
          flags = { allow_incremental_sync = true },
          init_options = {
            bundles = get_bundles(),
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            downloadSources = true,
          },
        }

        config.on_attach = function(client, bufnr)
          if jdtls.setup_dap then
            jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
            pcall(function()
              require("jdtls.dap").setup_dap_main_class_configs()
            end)
          end

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, async = false })
            end,
          })

          local opts = { buffer = bufnr, silent = true, noremap = true }
          vim.keymap.set("n", "<leader>oi", function()
            jdtls.organize_imports()
          end, vim.tbl_extend("keep", opts, { desc = "Organizar imports" }))
        end

        jdtls.start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          start_jdtls()
        end,
      })
    end,
  },
}
