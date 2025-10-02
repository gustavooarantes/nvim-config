-- Disabling the explorer and dashboard.
-- Folke loves this shit so much it has become pretty much impossible to remove it
-- So I am at least disabling what I don't want (everything)
return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = false },
  },
  config = function()
    -- Leader + e abre netrw
    vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "Open netrw", silent = true })

    -- Ajustes de netrw
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "netrw",
      callback = function()
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local f = vim.fn.expand("<afile>")
        if vim.fn.isdirectory(f) == 1 then
          vim.cmd.Lexplore()
        end
      end,
    })
  end,
}
