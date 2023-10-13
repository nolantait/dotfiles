return function()
  local buf_ft = vim.api.nvim_get_option_value("filetype", { scope = "local" })
  local clients = vim.lsp.get_active_clients()
  local lsp_lists = {}
  local available_servers = {}
  if next(clients) == nil then
    return ""  -- No server available
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    local client_name = client.name
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      -- Avoid adding servers that already exists.
      if not lsp_lists[client_name] then
        lsp_lists[client_name] = true
        table.insert(available_servers, client_name)
      end
    end
  end
  return next(available_servers) == nil and ""
      or string.format("%s %s", "", table.concat(available_servers, ", "))
end
