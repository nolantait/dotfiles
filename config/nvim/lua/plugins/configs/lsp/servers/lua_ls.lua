return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = {
          "vim",
          "it",
          "describe",
          "before_each",
          "after_each"
        }
      },
      hint = { enable = true, setType = true },
      format = { enable = true },
      telemetry = { enable = false },
      -- Do not override treesitter lua highlighting with lua_ls's highlighting
      semantic = { enable = false },
      workspace = {
        checkThirdParty = false,
      }
    }
  }
}
