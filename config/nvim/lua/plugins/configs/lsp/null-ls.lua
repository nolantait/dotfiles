return function()
  local null_ls = require("null-ls")

  null_ls.setup({
    update_in_insert = false,
    debounce = 5000,
    sources = {
      null_ls.builtins.diagnostics.erb_lint.with({
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      }),
    },
  })
end
