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
            completion = { favoriteStaticMembers = {} },
            format = { enabled = true },
          },
        },
      })
    end,
  },
}
