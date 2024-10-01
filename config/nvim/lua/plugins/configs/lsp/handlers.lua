local M = {}

M.setup = function()
  local icons = require("globals.icons")
  local utils = require("core.utils")

  -- Global config for diagnostics
  vim.diagnostic.config({
    document_highlight = { enable = true },
    virtual_text = false,
    inlay_hints = {
      enabled = true,
      exclude = {},
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.error,
        [vim.diagnostic.severity.WARN] = icons.warn,
        [vim.diagnostic.severity.HINT] = icons.hint,
        [vim.diagnostic.severity.INFO] = icons.info,
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
      source = true,
    },
  })

  -- vim.lsp.handlers["textDocument/inlayHint"] = vim.lsp.with(
  --   vim.lsp.handlers.inlay_hints,
  --   {
  --     prefix = " » ",
  --     highlight = "Comment",
  --     enabled = { "TypeHint", "ChainingHint", "ParameterHint" },
  --   }
  -- )

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = utils.border("FloatBorderDocs"),
      silent = true
    }
  )

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = utils.border("FloatBorderDocs"),
      silent = true
    }
  )

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      signs = true,
      underline = true,
      virtual_text = { severity = { min = vim.diagnostic.severity.HINT } },
      update_in_insert = false
    }
  )
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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument = {
  completion = {
    completionItem = {
      documentationFormat = { "markdown", "plaintext" },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      },
    }
  }
}

M.capabilities = capabilities

return M
