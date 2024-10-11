-- DOCS: Profiler for nvim

return function()
  local profile = require("profile")
  local should_profile = os.getenv("NVIM_PROFILE")

  if should_profile then
    profile.instrument_autocmds()

    if should_profile:lower():match("^start") then
      profile.start("*")
    else
      profile.instrument("*")
    end
  end

  local function toggle_profile()
    if profile.is_recording() then
      vim.notify("Stopping profile")
      profile.stop()

      vim.ui.input(
        {
          prompt = "Save profile to:",
          completion = "file",
          default = "/home/nolan/nvim-profile.json"
        },
        function(filename)
          if filename then
            profile.export(filename)
            vim.notify(string.format("Wrote %s", filename))
          end
        end
      )
    else
      vim.notify("Starting profile")
      profile.start("*")
    end
  end

  local command = vim.api.nvim_create_user_command

  command(
    "ToggleProfile",
    toggle_profile,
    { nargs = 0 }
  )

  local keymap = vim.api.nvim_set_keymap
  local opts = {
    noremap = true,
    silent = true
  }

  keymap("n", "<F3>", "<cmd>ToggleProfile<CR>", opts)
end
