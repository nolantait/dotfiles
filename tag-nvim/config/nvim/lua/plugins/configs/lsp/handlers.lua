local methods = vim.lsp.protocol.Methods

local M = {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

M.setup = function()
  local icons = require("globals.icons")
  local utils = require("core.utils")
  local severity = vim.diagnostic.severity

  -- Global config for diagnostics
  vim.diagnostic.config({
    -- virtual_lines = { current_line = true },
    virtual_text = true,
    inlay_hints = {
      enabled = true,
      exclude = {},
    },
    signs = {
      text = {
        [severity.ERROR] = icons.error,
        [severity.WARN] = icons.warn,
        [severity.HINT] = icons.hint,
        [severity.INFO] = icons.info,
      },
    },
    severity_sort = true,
    update_in_insert = false,
    underline = true,
    float = {
      focused = false,
      focusable = true,
      style = "minimal",
      border = utils.border("FloatBorder"),
      source = "if_many",
    },
  })
end

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

M.on_attach = function(client, buffer)
  lsp_attach_navic(client, buffer)

  local cap = client.server_capabilities

  if cap.documentHighlightProvider then
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
end

return M
