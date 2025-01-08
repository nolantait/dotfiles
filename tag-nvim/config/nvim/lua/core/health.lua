-- DOCS: Health check for this neovim setup
--
-- use with `:checkhealth core`

local M = {}

local health = vim.health

function M.check()
  health.start("Tainted Coders")

  -- health.info("AstroNvim Version: " .. require("astrocore.updater").version(true))
  health.info(
    "Neovim Version: v"
      .. vim.fn.matchstr(vim.fn.execute("version"), "NVIM v\\zs[^\n]*")
  )

  local programs = {
    {
      cmd = { "git" },
      type = "error",
      msg = "Used for core functionality such as updater and plugin management",
    },
    {
      cmd = { "node" },
      type = "warn",
      msg = "Used for various plugins",
    },
    {
      cmd = { "bat" },
      type = "warn",
      msg = "Used by aliases for `cat` for previewing files",
    },
    {
      cmd = { "eza" },
      type = "warn",
      msg = "Used by aliases for `ls`",
    },
    {
      cmd = { "mise" },
      type = "warn",
      msg = "Used for language tooling",
    },
  }

  for _, program in ipairs(programs) do
    local name = table.concat(program.cmd, "/")
    local found = false

    for _, cmd in ipairs(program.cmd) do
      if vim.fn.executable(cmd) == 1 then
        name = cmd

        if not program.extra_check or program.extra_check(program) then
          found = true
        end

        break
      end
    end

    if found then
      health.ok(("`%s` is installed: %s"):format(name, program.msg))
    else
      health[program.type](
        ("`%s` is not installed: %s"):format(name, program.msg)
      )
    end
  end
end

return M
