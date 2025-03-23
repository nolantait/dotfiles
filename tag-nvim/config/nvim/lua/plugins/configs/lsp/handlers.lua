local methods = vim.lsp.protocol.Methods

local M = {}

M.setup = function()
  local icons = require("globals.icons")
  local utils = require("core.utils")
  local severity = vim.diagnostic.severity

  -- Global config for diagnostics
  vim.diagnostic.config({
    document_highlight = { enable = true },
    virtual_text = { prefix = "", spacing = 2 },
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

  vim.lsp.handlers[methods.textDocument_signatureHelp] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      focusable = false,
      max_height = 7,
      border = utils.border("FloatBorderDocs"),
      silent = true,
    })

  vim.lsp.handlers[methods.textDocument_hover] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = utils.border("FloatBorderDocs"),
      silent = true,
    })

  vim.lsp.handlers[methods.textDocument_publishDiagnostics] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      underline = true,
      virtual_text = { severity = { min = vim.diagnostic.severity.HINT } },
      update_in_insert = false,
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

  -- if client:supports_method(methods.textDocument_documentHighlight) then
  --   -- Use LSP to highlight references under the cursor instead of Illuminate
  --   local ok, illuminate = pcall(require, "illuminate")
  --   if ok then
  --     illuminate.pause_buf()
  --   end
  --
  --   local augroup = vim.api.nvim_create_augroup("tainted/lsp-highlight", { clear = true })
  --   vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
  --     group = augroup,
  --     desc = "Highlight references under the cursor",
  --     buffer = buffer,
  --     callback = vim.lsp.buf.document_highlight,
  --   })
  --   vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
  --     group = augroup,
  --     desc = "Clear highlight references",
  --     buffer = buffer,
  --     callback = vim.lsp.buf.clear_references,
  --   })
  -- end

  if
    client:supports_method(methods.textDocument_inlayHint) and vim.g.inlay_hints
  then
    local inlay_hints_group = vim.api.nvim_create_augroup(
      "tainted/toggle-inlay-hints",
      { clear = false }
    )

    -- Initial inlay hint display.
    -- Idk why but without the delay inlay hints aren't displayed at the very start.
    vim.defer_fn(function()
      local mode = vim.api.nvim_get_mode().mode
      vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = buffer })
    end, 500)

    vim.api.nvim_create_autocmd("InsertEnter", {
      group = inlay_hints_group,
      desc = "Enable inlay hints",
      buffer = bufnr,
      callback = function()
        if vim.g.inlay_hints then
          vim.lsp.inlay_hint.enable(false, { bufnr = buffer })
        end
      end,
    })

    vim.api.nvim_create_autocmd("InsertLeave", {
      group = inlay_hints_group,
      desc = "Disable inlay hints",
      buffer = buffer,
      callback = function()
        if vim.g.inlay_hints then
          vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
        end
      end,
    })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = capabilities

return M
