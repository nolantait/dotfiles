return function(config)
  local ruby_dap = require("dap-ruby")
  local mason_nvim_dap = require("mason-nvim-dap")

  ruby_dap.setup()
  mason_nvim_dap.default_setup(config)
end
