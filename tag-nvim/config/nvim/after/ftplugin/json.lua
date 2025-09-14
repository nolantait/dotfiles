vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.foldlevel = 3
vim.keymap.set(
  "n",
  "<leader>rp",
  "<cmd>%! jq .<CR>",
  { desc = "Prettify Buffer" }
)
vim.keymap.set(
  "n",
  "<leader>rm",
  "<cmd>%! jq --compact-output .<CR>",
  { desc = "Minify Buffer" }
)
