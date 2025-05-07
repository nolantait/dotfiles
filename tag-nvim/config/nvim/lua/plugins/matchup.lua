-- DOCS: Customization for vim-matchup

return {
  {
    "andymass/vim-matchup",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    init = function()
      local g = vim.g

      -- Do not use builtin matchit.vim and matchparen.vim since the use of vim-matchup
      g.loaded_matchit = 1
      g.loaded_matchparen = 1

      g.matchup_matchparen_deferred = 1
      g.matchup_matchparen_deferred_show_delay = 100
      g.matchup_matchparen_hi_surround_always = 1
      g.matchup_override_vimtex = 1
      g.matchup_delim_start_plaintext = 0
      g.matchup_transmute_enabled = 0
      g.matchup_delim_stopline = 500
      g.matchup_matchparen_stopline = 500
    end,
  },
}
