-- DOCS: Health check for this neovim setup
--
-- use with `:checkhealth core`

local M = {}

local health = vim.health

function M.check()
  health.start "Tainted Coders"

  -- health.info("AstroNvim Version: " .. require("astrocore.updater").version(true))
  health.info("Neovim Version: v" .. vim.fn.matchstr(vim.fn.execute "version", "NVIM v\\zs[^\n]*"))

  if vim.version().prerelease then
    health.ok "Using prerelease Neovim, very cool."
  elseif vim.fn.has "nvim-0.9" == 1 then
    health.warn "Neovim stable will not show rubocop. Please use nightly for full features"
  else
    health.error "Neovim >= 0.9.0 is required"
  end

  local programs = {
    {
      cmd = { "git" },
      type = "error",
      msg = "Used for core functionality such as updater and plugin management",
    },
    {
      cmd = { "node" },
      type = "warn",
      msg = "Used for various plugins"
    },
  }

  for _, program in ipairs(programs) do
    local name = table.concat(program.cmd, "/")
    local found = false
    for _, cmd in ipairs(program.cmd) do
      if vim.fn.executable(cmd) == 1 then
        name = cmd
        if not program.extra_check or program.extra_check(program) then found = true end
        break
      end
    end

    if found then
      health.ok(("`%s` is installed: %s"):format(name, program.msg))
    else
      health[program.type](("`%s` is not installed: %s"):format(name, program.msg))
    end
  end
end

return M
