return function()
  local null_ls = require("null-ls")
  local mason_null_ls = require("mason-null-ls")

  null_ls.setup({
    update_in_insert = false,
    debounce = 5000,
    sources = {
      null_ls.builtins.diagnostics.erb_lint,
      null_ls.builtins.formatting.htmlbeautifier,
    },
  })

  mason_null_ls.setup({
    ensure_installed = {
      "erb_lint",
      "htmlbeautifier",
    },
    automatic_installation = true,
    handlers = {}
  })
end
