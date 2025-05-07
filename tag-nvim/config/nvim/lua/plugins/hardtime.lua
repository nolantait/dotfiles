-- DOCS: Gives hints on how to use Neovim better

local avoid_command_save = function()
  vim.api.nvim_create_user_command("W", function()
    vim.notify("Use <Leader>w instead of :w!", vim.log.levels.WARN)
    vim.cmd("write")
  end, {})
  vim.cmd("cnoreabbrev w W") -- Make `:w` call `:W`
end

local config = function()
  local hardtime = require("hardtime")

  hardtime.setup({
    restriction_mode = "hint",
    restricted_keys = {
      ["h"] = {},
      ["j"] = {},
      ["k"] = {},
      ["l"] = {},
      ["+"] = { "n", "x" },
      ["gj"] = { "n", "x" },
      ["gk"] = { "n", "x" },
      ["<C-M>"] = { "n", "x" },
      ["<C-N>"] = { "n", "x" },
      ["<C-P>"] = {},
    },
  })

  hardtime.enable()
end

return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    config = config,
    init = function()
      avoid_command_save()
    end,
  },
}
