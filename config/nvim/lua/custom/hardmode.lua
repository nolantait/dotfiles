local notify = require("core.messages")
local icons = require("globals.icons")

local M = {
  hard_mode = false
}

-- avoid repeating hjkl keys
local id
local avoid_hjkl = function(mode, mov_keys)
  for _, key in ipairs(mov_keys) do
    local count = 0
    vim.keymap.set(
      mode,
      key,
      function()
        if count >= 5 then
          id = notify.warn("Hold it Cowboy!", "Hardmode", {
            icon = icons.event .. " ",
            replace = id,
            keep = function()
              return count >= 5
            end,
          })
        else
          count = count + 1
          -- after 5 seconds decrement
          vim.defer_fn(function()
            count = count - 1
          end, 5000)
          return key
        end
      end,
      { expr = true }
    )
  end
end

-- Hard mode toggle
M.toggle_hard_mode = function()
  local modes = { "n", "v" }
  local movement_keys = { "h", "j", "k", "l" }

  if M.hard_mode then
    for _, mode in pairs(modes) do
      for _, m_key in pairs(movement_keys) do
        vim.api.nvim_del_keymap(mode, m_key)
      end
    end

    notify.info("Hard mode OFF", "Hardmode")
  else
    for _, mode in pairs(modes) do
      avoid_hjkl(mode, movement_keys)
    end

    notify.info("Hard mode ON", "Hardmode")
  end

  M.hard_mode = not M.hard_mode
end

vim.api.nvim_create_user_command(
  "ToggleHardMode",
  "lua require('custom.hardmode').toggle_hard_mode()",
  {
    nargs = 0,
  }
)

return M
