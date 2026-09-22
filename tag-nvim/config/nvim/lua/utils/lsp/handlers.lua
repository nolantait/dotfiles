-- DOCS: LSP handlers for Neovim

local M = {
  -- Start with the default capabilities
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

-- Set up LSP highlight references under the cursor
local function setup_lsp_highlight(buffer)
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

-- Pause Illuminate and use LSP to highlight references under the cursor
local function use_lsp_highlight(buffer)
  local ok, illuminate = pcall(require, "illuminate")
  if ok then
    illuminate.pause_buf()
  end

  setup_lsp_highlight(buffer)
end

-- Ruby LSP derives semantic tokens and pull diagnostics from the document
-- snapshot it holds when a request is handled. While it is busy (indexing,
-- running RuboCop, setting up the composed bundle) a response can end up
-- describing an older snapshot than the buffer, so Neovim keeps showing stale
-- highlights ("the colors go off") and errors that no longer exist. Neovim only
-- asks again on the next text change, which is why editing clears it up.
--
-- Re-request both once the editor settles and once the server has caught up, so
-- the buffer realigns on its own instead of needing another edit.
local ruby_resync_timers = {}

local function resync_ruby(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ruby" })
  if #clients == 0 then
    return
  end

  vim.lsp.semantic_tokens.force_refresh(bufnr)

  if vim.lsp.diagnostic and vim.lsp.diagnostic._refresh then
    for _, client in ipairs(clients) do
      vim.lsp.diagnostic._refresh(bufnr, client.id)
    end
  end
end

local function schedule_ruby_resync(bufnr)
  local timer = ruby_resync_timers[bufnr]
  if timer and not timer:is_closing() then
    timer:stop()
    timer:close()
  end

  timer = assert(vim.uv.new_timer())
  ruby_resync_timers[bufnr] = timer
  timer:start(
    150,
    0,
    vim.schedule_wrap(function()
      ruby_resync_timers[bufnr] = nil
      resync_ruby(bufnr)
    end)
  )
end

local function setup_ruby_resync()
  local augroup =
    vim.api.nvim_create_augroup("tainted/ruby-lsp-resync", { clear = true })

  vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
    group = augroup,
    desc = "Re-request Ruby LSP tokens and diagnostics after the buffer settles",
    callback = function(event)
      if vim.bo[event.buf].filetype == "ruby" then
        schedule_ruby_resync(event.buf)
      end
    end,
  })

  -- Ruby LSP reports background indexing through the `indexing-progress` token.
  -- When it finishes, every open document may have been re-indexed, so ask for
  -- fresh tokens and diagnostics.
  vim.api.nvim_create_autocmd("LspProgress", {
    group = augroup,
    desc = "Re-request Ruby LSP tokens and diagnostics after indexing",
    callback = function(event)
      local params = event.data.params
      local value = params.value

      if
        params.token ~= "indexing-progress"
        or type(value) ~= "table"
        or value.kind ~= "end"
      then
        return
      end

      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if not client or client.name ~= "ruby" then
        return
      end

      for bufnr in pairs(client.attached_buffers or {}) do
        schedule_ruby_resync(bufnr)
      end
    end,
  })
end

setup_ruby_resync()

function M.on_attach(client, buffer)
  lsp_attach_navic(client, buffer)

  local cap = client.server_capabilities

  if cap.documentHighlightProvider then
    use_lsp_highlight(buffer)
  end
end

return M
