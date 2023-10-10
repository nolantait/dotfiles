local ok, copilot = prequire("copilot")
if not ok then
  return
end

if copilot then
  copilot.setup({
    panel = { enabled = false },
    suggestion = { enabled = false },
    filetypes = {
      yaml = false,
      markdown = false,
      help = false,
      gitcommit = false,
      gitrebase = false,
      hgcommit = false,
      svn = false,
      cvs = false,
      ["."] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 16.x
    server_opts_overrides = {},
  })
end
