return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      doc = {
        privateName = { "^_" },
      },
      diagnostics = {
        globals = {
          "vim",
          "it",
          "describe",
          "before_each",
          "after_each",
        },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      format = { enable = true },
      telemetry = { enable = false },
      -- Do not override treesitter lua highlighting with lua_ls's highlighting
      semantic = { enable = false },
      codeLens = { enable = true },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}
