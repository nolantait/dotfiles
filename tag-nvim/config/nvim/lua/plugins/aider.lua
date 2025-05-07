-- DOCS: AI coding assistant for Neovim with open source aider
-- https://aider.chat/

return {
  {
    "joshuavial/aider.nvim",
    enabled = false,
    keys = {
      {
        "<Leader>ai",
        mode = "n",
        desc = "Open ai with Aider",
        function()
          require("aider").open({
            no_auto_commits = true,
            no_attribute_committer = true,
            no_attribute_author = true,
          })
        end,
      },
    },
    opts = {
      auto_manage_context = true,
      default_bindings = false,
      debug = false,
      ignore_buffers = {
        "^term:",
        "NeogitConsole",
        "NvimTree_",
        "neo-tree filesystem",
      },
    },
  },
}
