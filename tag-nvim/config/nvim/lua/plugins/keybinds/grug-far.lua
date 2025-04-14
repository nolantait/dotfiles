return {
  {
    mode = "n",
    key = "<Leader>rf",
    command = "<cmd>lua require'grug-far'.open({ transient = true, prefills = { paths = vim.fn.expand('%') } })<CR>",
    description = "Open find and replace in file",
  },
  {
    mode = { "n", "v" },
    key = "<Leader>ra",
    command = "<cmd>lua require'grug-far'.open({ transient = true })<CR>",
    description = "Open find and replace in all files",
  },
}
