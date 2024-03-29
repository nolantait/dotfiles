return {
  {
    mode = "n",
    key = ";",
    command = "<cmd>Telescope resume<CR>",
    description = "Resume the last telescope list",
  },
  {
    mode = "n",
    key = "<C-p>",
    command = "<cmd>Telescope find_files<CR>",
    description = "Search files with Telescope using git-ls with fallback",
  },
  {
    mode = "n",
    key = "<C-|>",
    command = "<cmd>Telescope frecency workspace=CWD<CR>",
    description = "Search frequently used files with Telescope using frecency",
  },
  {
    mode = "n",
    key = "\\",
    command = "<cmd>Telescope live_grep<CR>",
    description = "Grep files with '\\'",
  },
  {
    mode = "n",
    key = "to",
    command = "<cmd>Telescope oldfiles<CR>",
    description = "View recently accessed files",
  },
  {
    mode = "n",
    key = "tm",
    command = "<cmd>Telescope man_pages<CR>",
    description = "Find man pages",
  },
  {
    mode = "n",
    key = "tn",
    command = "<cmd>Telescope notify<CR>",
    description = "See previous notifications",
  },
  {
    mode = "n",
    key = "thi",
    command = "<cmd>Telescope highlights<CR>",
    description = "Search through highlights",
  },
  {
    mode = "n",
    key = "tv",
    command = "<cmd>Telescope vim_options<CR>",
    description = "Search through vim options",
  },
  {
    mode = "n",
    key = "the",
    command = "<cmd>Telescope help_tags<CR>",
    description = "Search through help tags in man pages",
  },
  {
    mode = "n",
    key = "tk",
    command = "<cmd>Telescope keymaps<CR>",
    description = "Search through your keymaps",
  },
  {
    mode = "n",
    key = "td",
    command = "<cmd>Telescope diagnostics<CR>",
    description = "Navigate through current diagnostics",
  },
  {
    mode = "n",
    key = "tc",
    command = "<cmd>Telescope command_history<CR>",
    description = "Command history",
  },
  {
    mode = "n",
    key = "ta",
    command = "<cmd>Telescope autocommands<CR>",
    description = "Autocommands finder",
  },
  {
    mode = "n",
    key = "<Leader>bf",
    command = "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    description = "Buffer fuzzy finder",
  },
}
