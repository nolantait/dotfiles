return {
  {
    mode = "n",
    key = "T",
    command = "<cmd>TestOutputPanel<CR>",
    description = "Open test output panel"
  },
  {
    mode = "n",
    key = "<C-t>",
    command = "<cmd>TestOutput<CR>",
    description = "Open test output"
  },
  {
    mode = "n",
    key = "ts",
    command = "<cmd>TestSummary<CR>",
    description = "Toggle test summary",
  },
  {
    mode = "n",
    key = "<Leader>?",
    command = "<cmd>TestDap<CR>",
    description = "Test with dap",
  },
  {
    mode = "n",
    key = "<leader>s",
    command = "<cmd>TestNearest<CR>",
    description = "Run nearest test",
  },
  {
    mode = "n",
    key = "<leader>t",
    command = "<cmd>TestFile<CR>",
    description = "Run current test file",
  },
}
