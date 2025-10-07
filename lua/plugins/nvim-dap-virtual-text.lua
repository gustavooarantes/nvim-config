-- nvim-dap-virtual-text.lua
-- Inline debug variable display
return {
  "theHamsta/nvim-dap-virtual-text",
  lazy = true,
  opts = {
    commented = true, -- Show virtual text as comments
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == "inline" then
        return " = " .. variable.value
      else
        return variable.name .. " = " .. variable.value
      end
    end,
  },
  config = function(_, opts)
    require("nvim-dap-virtual-text").setup(opts)
  end,
}
