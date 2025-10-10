-- vim-tmux-navigator.lua
return {
  "christoomey/vim-tmux-navigator",
  cond = function()
    return vim.fn.exists("$TMUX") == 1
  end,
}
