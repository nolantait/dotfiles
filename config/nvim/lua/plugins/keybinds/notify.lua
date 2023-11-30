return {
  {
    mode = "n",
    key = "<Leader>un",
    command = "<cmd>lua require('notify').dismiss({silent = true, pending = true})<CR>",
    description = "Dismiss all notifications",
  },
}
