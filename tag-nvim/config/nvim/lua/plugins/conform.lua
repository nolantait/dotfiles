-- DOCS: Sets up auto formatting for files

local format = function(args)
  local range = nil

  if args.count ~= -1 then
    local end_line =
      vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end

  require("conform").format({
    timeout_ms = 3000,
    async = false,
    quiet = false,
    lsp_format = "fallback",
    range = range,
  })
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    init = function()
      vim.api.nvim_create_user_command("Format", format, { range = true })
    end,
    keys = {
      {
        "<leader>f",
        function()
          vim.cmd("Format")
        end,
        desc = "LSP format with conform",
      },
    },
    opts = {
      notify_on_error = true,
      formatters = {
        topcoat = {
          command = "topcoat",
          args = { "fmt", "--stdin" },
          require_cwd = true,
          cwd = function(self, ctx)
            return require("conform.util").root_file({ "Topcoat.toml" })(
              self,
              ctx
            )
          end,
        },
      },
      formatters_by_ft = {
        bash = { "shfmt" },
        css = { "prettier" },
        gdscript = { "gdformat" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        lua = { "stylua" },
        markdown = { "trim_whitespace", "trim_newlines" },
        python = { "ruff_format" },
        rust = { "topcoat", lsp_format = "first" },
        sh = { "shfmt" },
        svg = { "htmlbeautifier" },
        toml = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        zsh = { lsp_format = "fallback" },
      },
    },
  },
}
