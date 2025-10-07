return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local jdtls = require("jdtls")
      local root_dir = require("lspconfig.util").root_pattern("pom.xml", "build.gradle", ".git")(vim.fn.expand("%:p"))
      if not root_dir then
        return
      end

      jdtls.start_or_attach({
        cmd = { "jdtls" },
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
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.java",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
}
