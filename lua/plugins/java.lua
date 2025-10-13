-- java.lua
local home = vim.env.HOME

return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")

      -- Project workspace
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = home .. "/jdtls-workspace/" .. project_name

      -- Detect OS
      local system_os = ""
      if vim.fn.has("mac") == 1 then
        system_os = "mac"
      elseif vim.fn.has("unix") == 1 then
        system_os = "linux"
      elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
        system_os = "win"
      else
        system_os = "linux"
      end

      -- Debug + test bundles
      local bundles = {
        vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
      }
      vim.list_extend(
        bundles,
        vim.split(vim.fn.glob(home .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n")
      )

      -- Root dir detection
      local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" })
      if not root_dir then
        return
      end

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
            home = "/usr/lib/jvm/java-21-openjdk",
            eclipse = { downloadSources = true },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                { name = "JavaSE-1.8", path = "/usr/lib/jvm/java-8-openjdk" },
                { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk" },
                { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
                { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk" },
                { name = "JavaSE-25", path = "/usr/lib/jvm/java-25-openjdk" },
              },
            },
            maven = { downloadSources = true },
            format = { enabled = true },
            completion = { favoriteStaticMembers = {} },
          },
        },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        flags = { allow_incremental_sync = true },
        init_options = { bundles = bundles, extendedClientCapabilities = jdtls.extendedClientCapabilities },
      }

      config.on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto", config_overrides = {} })
        require("jdtls.dap").setup_dap_main_class_configs()

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end

      jdtls.start_or_attach(config)
    end,
  },
}
