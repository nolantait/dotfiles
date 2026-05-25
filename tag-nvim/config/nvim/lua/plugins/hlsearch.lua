-- DOCS: Auto remove search highlight and rehighlight when using n or N

return {
  {
    "nvimdev/hlsearch.nvim",
    config = true,
    event = "LazyFile",
  },
}
