local M = {}

M.setup = function()
  local icons = require("globals.icons")
  local utils = require("core.utils")

  local signs = {
    { name = "DiagnosticSignError", text = icons.error },
    { name = "DiagnosticSignWarn", text = icons.warn },
    { name = "DiagnosticSignHint", text = icons.hint },
    { name = "DiagnosticSignInfo", text = icons.info },
  }

  for _, sign in ipairs(signs) do
    if not sign.texthl then sign.texthl = sign.name end
    vim.fn.sign_define(sign.name, sign)
  end

  -- Global config for diagnostics
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focused = false,
      focusable = true,
      style = "minimal",
      border = utils.border("FloatBorder"),
      source = "always",
    },
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = utils.border("FloatBorderDocs")
  })

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = true,
    underline = true,
    virtual_text = {
      severity_limit = "Hint",
    },
    update_in_insert = false
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

-- Setup LSP keybinds
local function setup_lsp_keymaps(buffer)
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = buffer }

  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "ca", vim.lsp.buf.code_action, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
  keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

M.on_attach = function(client, buffer)
  lsp_attach_navic(client, buffer)
  setup_lsp_keymaps(buffer)
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
