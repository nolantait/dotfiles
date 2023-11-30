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
    debounce = 2500,
    sources = {
      -- Anything not supported by mason goes here
    },
  })
end
