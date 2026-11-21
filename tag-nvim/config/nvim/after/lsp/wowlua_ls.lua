---@type vim.lsp.Config
return {
  cmd = { "wowlua_ls" },
  filetypes = { "lua", "toc" },
  root_dir = function(bufnr, on_dir)
    on_dir(
      vim.fs.root(bufnr, ".wowluarc.json")
        or vim.fs.root(bufnr, function(name)
          return name:match("%.toc$") ~= nil
        end)
        or vim.fs.root(bufnr, ".git")
    )
  end,
  workspace_required = false,
}
