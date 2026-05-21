-- DOCS: Auto remove search highlight and rehighlight when using n or N

return {
  {
    "nvimdev/hlsearch.nvim",
    enabled = false,
    config = true,
    event = "LazyFile",
  },
}
