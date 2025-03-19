return {
  {
    mode = "n",
    key = "<Leader>un",
    command = "<cmd>lua require('snacks').notifier.hide()<CR>",
    description = "Dismiss all notifications",
  },
  {
    mode = "n",
    key = "<Leader>uh",
    command = "<cmd>lua require('snacks').notifier.show_history()<CR>",
    description = "Show notification history",
  },
  {
    mode = "n",
    key = "<Leader>zm",
    command = "<cmd>lua require('snacks').zen()<CR>",
    description = "Enable zen mode",
  },
  {
    mode = { "n", "t" },
    key = "[[",
    command = "<cmd>lua require('snacks').words.jump(vim.v.count1)<CR>",
    description = "Next reference",
  },
  {
    mode = { "n", "t" },
    key = "]]",
    command = "<cmd>lua require('snacks').words.jump(-vim.v.count1)<CR>",
    description = "Previous reference",
  },
  {
    mode = "n",
    key = "<leader>gh",
    command = "<cmd>lua require('snacks').gitbrowse.open()<CR>",
    description = "Open file in github",
  },

}
