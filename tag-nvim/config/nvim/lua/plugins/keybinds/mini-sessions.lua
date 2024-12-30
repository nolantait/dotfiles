return {
  {
    mode = "n",
    key = "<Leader>1",
    command = "<cmd>lua MiniSessions.select()<CR>",
    description = "Choose a session",
  },
  {
    mode = "n",
    key = "<Leader>2",
    command = "<cmd>lua MiniSessions.select('remove')<CR>",
    description = "Remove a session",
  },
}
