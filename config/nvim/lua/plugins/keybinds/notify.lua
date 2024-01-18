return {
  {
    mode = "n",
    key = "<Leader>dn",
    command = "<cmd>lua require('notify').dismiss({silent = true, pending = true})<CR>",
    description = "Dismiss all notifications",
  },
}
