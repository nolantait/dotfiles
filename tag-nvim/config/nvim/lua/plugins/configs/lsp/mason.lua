local M = {}

M.setup = function()
  local mason = require("mason")
  local icons = require("globals.icons")

  mason.setup({
    ui = {
      icons = {
        package_installed = icons.check,
        package_pending = icons.download,
        package_uninstalled = icons.x_mark,
      },
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  })
end

return M
