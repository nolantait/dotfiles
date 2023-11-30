return function()
  local null_ls = require("null-ls")
  local mason_null_ls = require("mason-null-ls")

  mason_null_ls.setup({
    ensure_installed = {
      "erb-lint"
    },
    automatic_installation = true,
    handlers = {}
  })

  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.erb_lint.with({}),
      null_ls.builtins.formatting.erb_lint.with({}),
    },
  })
end
