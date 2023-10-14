return {
  {
    mode = "n",
    key = "?",
    command = "<cmd>lua vim.diagnostic.open_float({max_height=400})<CR>",
    description = "Open diagnostic float window",
  },
  {
    mode = "n",
    key = "[d",
    command = "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    description = "Go to previous diagnostic",
  },
  {
    mode = "n",
    key = "]d",
    command = "<cmd>lua vim.diagnostic.goto_next()<CR>",
    description = "Go to next diagnostic",
  },
  {
    mode = "n",
    key = "<leader>q",
    command = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    description = "Set diagnostic list",
  },
}
