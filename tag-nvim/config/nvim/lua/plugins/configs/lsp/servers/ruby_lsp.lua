local function add_ruby_deps_command(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps", function(opts)
    local params = vim.lsp.util.make_text_document_params()
    local showAll = opts.args == "all"

    client.request("rubyLsp/workspace/dependencies", params, function(error, result)
      if error then
        print("Error showing deps: " .. error)
        return
      end

      local qf_list = {}
      for _, item in ipairs(result) do
        if showAll or item.dependency then
          table.insert(qf_list, {
            text = string.format("%s (%s) - %s", item.name, item.version, item.dependency),
            filename = item.path
          })
        end
      end

      vim.fn.setqflist(qf_list)
      vim.cmd('copen')
    end, bufnr)
  end,
  {nargs = "?", complete = function() return {"all"} end})
end

return function(default_handlers)
  local on_attach = default_handlers.on_attach
  local handlers = vim.tbl_extend("force", {}, default_handlers)

  handlers.on_attach = function(client, bufnr)
    add_ruby_deps_command(client, bufnr)

    if on_attach then
      on_attach(client, bufnr)
    end
  end

  handlers.init_options = {
    formatter = "rubocop",
    linters = { "rubocop" },
    indexing = {
      excludedGems = {
        "bootsnap",
        "pg",
        "sqlite3",
        "stimulus-rails",
        "turbo-rails",
        "tzinfo-data",
        "title",
        "aws-sdk-s3",
        "debug",
        "rubocop-inhouse",
        "launchy",
        "phlex-testing-capybara",
        "shoulda-matchers",
        "brakeman",
        "bundler-audit",
        "database_consistency",
        "dockerfile-rails",
        "letter_opener_web",
        "overcommit",
        "syntax_suggest",
        "web-console"
      },
    }
  }

  require("lspconfig")["ruby_lsp"].setup(handlers)
end
