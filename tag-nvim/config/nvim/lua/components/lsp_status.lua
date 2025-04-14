return function()
  -- local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    if not string.match(client.name, "copilot") then
      return string.format("%s %s", "", client.name)
    end
  end

  return "" -- No server available
end
