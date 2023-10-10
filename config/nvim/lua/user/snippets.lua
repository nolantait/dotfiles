local ok, luasnip = prequire("luasnip")
if not ok then
  return
end

if luasnip then
  -- Add Rails snippets
  luasnip.filetype_extend("ruby", {"rails"})

  -- some shorthands...
  -- local snip = config.snippet
  -- local node = config.snippet_node
  -- local text = config.text_node
  -- local insert = config.insert_node
  -- local func = config.function_node
  -- local choice = config.choice_node
  -- local dynamicn = config.dynamic_node

  -- local date = function() return {os.date('%Y-%m-%d')} end

  -- config.add_snippets(nil, {
  --     all = {
  --         snip({
  --             trig = "date",
  --             namr = "Date",
  --             dscr = "Date in the form of YYYY-MM-DD",
  --         }, {
  --             func(date, {}),
  --         }),
  --     },
  -- })

  -- local keymap = vim.api.nvim_set_keymap
  -- local opts = { noremap = true, silent = true }
  -- keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
  -- keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
  -- keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
  -- keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
end
