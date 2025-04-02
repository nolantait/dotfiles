local M = {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

-- Provides navigation for LSP symbols for barbecue.nvim
local function lsp_attach_navic(client, bufnr)
  local ok, navic = prequire("nvim-navic")
  if not ok then
    return
  end

  -- Set autocommands conditional on server_capabilities
  if navic and client.server_capabilities["documentSymbolProvider"] then
    navic.attach(client, bufnr)
  end
end

local function use_lsp_highlight(buffer)
  -- Use LSP to highlight references under the cursor instead of Illuminate
  local ok, illuminate = pcall(require, "illuminate")
  if ok then
    illuminate.pause_buf()
  end

  local augroup =
    vim.api.nvim_create_augroup("tainted/lsp-highlight", { clear = true })

  vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
    group = augroup,
    desc = "Highlight references under the cursor",
    buffer = buffer,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
    group = augroup,
    desc = "Clear highlight references",
    buffer = buffer,
    callback = vim.lsp.buf.clear_references,
  })
end

function M.on_attach(client, buffer)
  lsp_attach_navic(client, buffer)

  local cap = client.server_capabilities

  if cap.documentHighlightProvider then
    use_lsp_highlight(buffer)
  end
end

return M
