-- DOCS: Keybind helper, pops up a window with all possible keybinds for a motion

return {
  {
    -- Show keymaps on partial completion at the bottom of the screen
    "echasnovski/mini.clue",
    event = { "CursorHold", "CursorHoldI" },
    version = "*",
    opts = {
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- `t` key
        { mode = "n", keys = "t" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        -- mini.surround keys
        { mode = "n", keys = "s" },

        -- Avante keys
        { mode = "n", keys = "<Leader>a" },
      },
      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        -- require("mini.clue").gen_clues.builtin_completion(),
        -- require("mini.clue").gen_clues.g(),
        -- require("mini.clue").gen_clues.marks(),
        -- require("mini.clue").gen_clues.registers(),
        -- require("mini.clue").gen_clues.windows(),
        -- require("mini.clue").gen_clues.z(),
      },
      window = {
        -- Floating window config
        config = {
          height = 100,
          width = 50,
        },

        -- Delay before showing clue window
        delay = 750,

        -- Keys to scroll inside the clue window
        scroll_down = "<C-j>",
        scroll_up = "<C-k>",
      },
    },
  },
}
