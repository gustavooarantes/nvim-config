-- project.lua
-- Project management via project.nvim
return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  opts = {
    -- Detect project root automatically
    detection_methods = { "pattern", "lsp" },
    patterns = { ".git", "package.json", "pyproject.toml", "pom.xml", "build.gradle" },
    -- Optional: store known projects (can speed up switching)
    -- manual_mode = false,
  },
  config = function(_, opts)
    local project = require("project_nvim")
    project.setup(opts)

    -- Optional: integrate with Telescope
    require("telescope").load_extension("projects")

    -- Optional: auto change cwd on project switch
    vim.api.nvim_create_autocmd("User", {
      pattern = "ProjectChanged",
      callback = function()
        print("Switched to project root: " .. vim.loop.cwd())
      end,
    })
  end,
}
