-- DOCS: Save and restore sessions with :mksession

return function()
  local mini_sessions = require("mini.sessions")
  local settings = require("globals.settings")

  mini_sessions.setup({
    -- Whether to read latest session if Neovim opened without file arguments
    autoread = false,

    -- Whether to write current session before quitting Neovim
    autowrite = true,

    -- Directory where global sessions are stored (use `''` to disable)
    directory = settings.cache_dir .. "/sessions", --<"session" subdir of user data directory from |stdpath()|>,

    -- File for local session (use `''` to disable)
    file = "Session.vim",

    -- Whether to force possibly harmful actions (meaning depends on function)
    force = {
      read = false,
      write = true,
      delete = false
    },

    -- Hook functions for actions. Default `nil` means 'do nothing'.
    -- Takes table with active session data as argument.
    hooks = {
      -- Before successful action
      pre = {
        read = nil,
        write = nil,
        delete = nil
      },
      -- After successful action
      post = {
        read = nil,
        write = nil,
        delete = nil
      },
    },

    -- Whether to print session path after action
    verbose = { read = false, write = true, delete = true },
  })

  vim.cmd([[ command! -nargs=1 WriteSession lua MiniSessions.write(<f-args>) ]])
end
