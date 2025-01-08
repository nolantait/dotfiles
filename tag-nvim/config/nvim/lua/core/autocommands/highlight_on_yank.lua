-- DOCS: Briefly highlights the yanked text to give some visual feedback

return function()
  vim.highlight.on_yank({
    higroup = "Visual",
    timeout = 200,
  })
end
