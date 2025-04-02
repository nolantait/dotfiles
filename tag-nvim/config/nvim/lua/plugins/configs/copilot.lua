-- DOCS: Copilot setup

return function()
  local copilot = require("copilot")

  copilot.setup({
    cmp = {
      enabled = true,
      method = "getCompletionsCycling",
    },
    copilot_node_command = "node", -- Node.js version must be > 16.x
    filetypes = {
      alpha = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      text = false,
      ["neo-tree"] = false,
      ["dap-repl"] = false,
      ["yaml.ansible"] = true,
      ["."] = false,
    },
    panel = {
      -- Disabled to not interfere with copilot-cmp
      enabled = false,
    },
    suggestion = {
      -- Disabled to not interfere with copilot-cmp
      enabled = false,
    },
    server_opts_overrides = {},
  })
end
