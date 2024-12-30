-- DOCS: Makes editing big files faster by disabling certain features

return function()
  local bigfile = require("bigfile")

  local cmp = {
    name = "nvim-cmp",
    opts = { defer = false },
    disable = function()
      local ok, cmp = pcall(require, "cmp")
      if ok then
        cmp.setup.buffer({ enabled = false })
      end
    end,
  }

  local barbeque = {
    name = "barbeque",
    opts = { defer = false },
    disable = function()
      local ok, barbeque = pcall(require, "barbecue.ui")
      if ok then
        barbeque.toggle(false)
      end
    end
  }

  local tscontext = {
    name = "tscontext",
    opts = { defer = false },
    disable = function()
      local ok, _ = pcall(require, "treesitter-context")
      if ok then
        vim.cmd("TSContextDisable")
      end
    end
  }

  local lualine = {
    name = "lualine",
    opts = { defer = false },
    disable = function()
      local ok, lualine = pcall(require, "lualine")
      if ok then
        lualine.hide({ unhide = false })
      end
    end
  }

  local colorizer = {
    name = "nvim-highlight-colors",
    opts = { defer = false },
    disable = function()
      local ok, colorizer = pcall(require, "nvim-highlight-colors")
      if ok then
        colorizer.turnOff()
      end
    end
  }

  bigfile.setup({
    filesize = 1,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
    pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
    features = {       -- features to disable
      "indent_blankline",
      "illuminate",
      "lsp",
      "treesitter",
      "syntax",
      "matchparen",
      "vimopts",
      "filetype",
      cmp,
      barbeque,
      tscontext,
      lualine,
      colorizer
    },
  })
end
