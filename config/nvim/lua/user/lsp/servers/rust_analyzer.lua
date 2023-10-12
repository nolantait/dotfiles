return function(handlers)
  local _ok, rust_tools = prequire("rust-tools")
  if not _ok then
    return
  end

  if rust_tools then
    rust_tools.setup({
      server = {
        capabilities = handlers.capabilities,
        on_attach = function(client, bufnr)
          handlers.on_attach(client, bufnr)
          -- Hover actions
          vim.keymap.set(
            "n",
            "<C-space>",
            rust_tools.hover_actions.hover_actions,
            { buffer = bufnr }
          )
          -- Code action groups
          vim.keymap.set(
            "n",
            "<Leader>a",
            rust_tools.code_action_group.code_action_group,
            { buffer = bufnr }
          )
        end,
      },
    })
  end
end
