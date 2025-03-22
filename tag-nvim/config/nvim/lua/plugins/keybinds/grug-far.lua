return {
  {
    mode = "n",
    key = "<Leader>fr",
    command = "<cmd>lua require'grug-far'.open({ transient = true, prefills = { paths = vim.fn.expand('%') } })<CR>",
    description = "Open find and replace in file",
  },
  {
    mode = { "n", "v" },
    key = "<Leader>fa",
    command = "<cmd>lua require'grug-far'.open({ transient = true })<CR>",
    description = "Open find and replace in all files",
  },

}

