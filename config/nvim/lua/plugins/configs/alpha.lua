-- Startup dashboard screen when you open neovim

return function()
  local alpha = require("alpha")
  local dashboard = require("alpha.themes.dashboard")
  local icons = require("globals.icons")

  dashboard.section.header.val = {
    [[ ████████╗ █████╗ ██╗███╗   ██╗████████╗███████╗██████╗   ]],
    [[ ╚══██╔══╝██╔══██╗██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗  ]],
    [[    ██║   ███████║██║██╔██╗ ██║   ██║   █████╗  ██║  ██║  ]],
    [[    ██║   ██╔══██║██║██║╚██╗██║   ██║   ██╔══╝  ██║  ██║  ]],
    [[    ██║   ██║  ██║██║██║ ╚████║   ██║   ███████╗██████╔╝  ]],
    [[    ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═════╝   ]],
    [[                                                          ]],
    [[     ██████╗ ██████╗ ██████╗ ███████╗██████╗ ███████╗     ]],
    [[    ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔══██╗██╔════╝     ]],
    [[    ██║     ██║   ██║██║  ██║█████╗  ██████╔╝███████╗     ]],
    [[    ██║     ██║   ██║██║  ██║██╔══╝  ██╔══██╗╚════██║     ]],
    [[    ╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║███████║     ]],
    [[     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚══════╝     ]],
  }

  dashboard.section.buttons.val = {
    dashboard.button("s", icons.source .. " Open session", "<cmd>lua MiniSessions.select()<CR>"),
    dashboard.button("f", icons.files.find .. " Find file", "<cmd>Telescope find_files<CR>"),
    dashboard.button("e", icons.files.new .. " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", icons.files.code .. " Frequently used files", "<cmd>Telescope frecency workspace=CWD<CR>"),
    dashboard.button("\\", icons.text .. " Find text", "<cmd>Telescope live_grep <CR>"),
    dashboard.button("u", icons.download .. " Update plugins", "<cmd>Lazy sync<cr>"),
    dashboard.button("U", icons.download .. " Update language servers", "<cmd>MasonUpdateAll<CR>"),
    dashboard.button("c", icons.gear .. " Configuration", ":e ~/.config/nvim<CR>"),
    dashboard.button("q", icons.cross .. " Quit Neovim", ":qa<CR>"),
  }

  -- Footer
  local function footer()
    -- NOTE: requires the fortune-mod package to work
    -- local handle = io.popen("fortune")
    -- local fortune = handle:read("*a")
    -- handle:close()
    -- return fortune

    -- Number of plugins
    local stats = require("lazy").stats()
    local ms = stats.startuptime
    local plugins_text = icons.vim
        .. " v"
        .. vim.version().major
        .. "."
        .. vim.version().minor
        .. "."
        .. vim.version().patch
        .. "     "
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"

    -- Quote
    local fortune = require("alpha.fortune")
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()
  dashboard.section.footer.opts.hl = "AlphaFooter"
  dashboard.section.header.opts.hl = "AlphaHeader"

  local head_butt_padding = 1
  local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
  local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
  local foot_butt_padding = 0

  dashboard.config.layout = {
    { type = "padding", val = header_padding },
    dashboard.section.header,
    { type = "padding", val = head_butt_padding },
    dashboard.section.buttons,
    { type = "padding", val = foot_butt_padding },
    dashboard.section.footer,
  }

  dashboard.config.opts.noautocmd = true

  -- Autocommand to hide top and bottom tablines
  vim.cmd([[
    augroup _alpha
      autocmd!
      autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
    augroup end
  ]])

  alpha.setup(dashboard.config)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
      dashboard.section.footer.val = footer()
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end
