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

  local syntax = {
    name = "syntax",
    opts = { defer = false },
    disable = function()
      vim.cmd("syntax off")
      vim.cmd("filetype off")
      vim.opt.undofile = false
      vim.opt.swapfile = false
      vim.g.loaded_plugins = 1
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

  local miniMap = {
    name = "minimap",
    opts = { defer = false },
    disable = function()
      vim.b.minimap_disable = true
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
      syntax,
      barbeque,
      tscontext,
      lualine,
      miniMap
    },
  })
end
