-- DOCS: Ruby plugins for Neovim

return {
  {
    "rgroli/other.nvim",
    ft = { "ruby", "eruby" },
    config = function()
      local in_pack = function(file)
        return file:find("/packs/", 1, true) ~= nil
      end

      -- packs/<pack>/app/<layer>/<rest>.rb -> packs/<pack>/spec/<layer>/<pack>/<rest>_spec.rb
      local pack_source = function(file)
        local root, pack, layer, rest =
          file:match("^(.*)/packs/([^/]+)/app/([^/]+)/(.+)%.rb$")
        if root then
          return { root, pack, layer, rest }
        end
        return nil
      end
      -- packs/<pack>/spec/<layer>/<pack>/<rest>_spec.rb -> packs/<pack>/app/<layer>/<rest>.rb
      local pack_spec_reverse = function(file)
        local root, pack, layer, _, rest =
          file:match("^(.*)/packs/([^/]+)/spec/([^/]+)/([^/]+)/(.+)%_spec%.rb$")
        if root then
          return { root, pack, layer, rest }
        end
        return nil
      end
      -- app/<layer>/<rest>.rb -> spec/<layer>/<rest>_spec.rb  (root + packages, where pack name is already mirrored)
      local source = function(file)
        if in_pack(file) then
          return nil
        end
        local root, layer, rest = file:match("^(.*)/app/([^/]+)/(.+)%.rb$")
        if root then
          return { root, layer, rest }
        end
        return nil
      end
      -- spec/<layer>/<rest>_spec.rb -> app/<layer>/<rest>.rb
      local spec_reverse = function(file)
        if in_pack(file) then
          return nil
        end
        local root, layer, rest =
          file:match("^(.*)/spec/([^/]+)/(.+)%_spec%.rb$")
        if root then
          return { root, layer, rest }
        end
        return nil
      end

      require("other-nvim").setup({
        mappings = {
          {
            pattern = pack_source,
            target = {
              { target = "%1/packs/%2/spec/%3/%2/%4_spec.rb", context = "test" },
            },
          },
          {
            pattern = pack_spec_reverse,
            target = "%1/packs/%2/app/%3/%4.rb",
          },
          {
            pattern = source,
            target = {
              { target = "%1/spec/%2/%3_spec.rb", context = "test" },
            },
          },
          {
            pattern = spec_reverse,
            target = "%1/app/%2/%3.rb",
          },
        },
      })

      vim.api.nvim_create_user_command("A", function()
        require("other-nvim").open()
      end, { desc = "Open the other/alternate file" })
      vim.api.nvim_create_user_command("AS", function()
        require("other-nvim").openSplit()
      end, { desc = "Open the other/alternate file in a horizontal split" })
      vim.api.nvim_create_user_command("AV", function()
        require("other-nvim").openVSplit()
      end, { desc = "Open the other/alternate file in a vertical split" })
      vim.api.nvim_create_user_command("AT", function()
        require("other-nvim").openTabNew()
      end, { desc = "Open the other/alternate file in a new tab" })
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    init = function()
      vim.g.rails_no_alternate_commands = true
    end,
  },
  {
    "tpope/vim-rake",
    ft = { "ruby", "eruby" },
  },
}
