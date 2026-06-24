local port = os.getenv("GDScript_Port") or "6005"
local cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))
local pipe = "/tmp/godot.pipe" -- I use /tmp/godot.pipe

return {
  name = "Godot",
  cmd = cmd,
  root_markers = {
    "project.godot",
    ".git",
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
  end,
}
