-- https://github.com/nvim-mini/mini.clue
local clue = require('mini.clue')

clue.setup {
  triggers = {
    -- Leader
    { mode = { 'n', 'x' }, keys = '<leader>' },

    -- `[` and `]` keys
    { mode = 'n',          keys = '[' },
    { mode = 'n',          keys = ']' },

    -- Built-in completion
    { mode = 'i',          keys = '<C-x>' },

    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },

    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },

    -- Window commands
    { mode = 'n',          keys = '<C-w>' },

    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },

    -- Conflict with LSP shortcuts, so disabled for now
    -- `g` key
    -- { mode = { 'n', 'x' }, keys = 'g' },

  },
  clues = {
    clue.gen_clues.square_brackets(),
    clue.gen_clues.builtin_completion(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.windows(),
    clue.gen_clues.z(),
    -- Conflict with LSP shortcuts, so disabled for now
    -- clue.gen_clues.g(),
  },
  window = {
    delay = 100,
    config = {
      width = 'auto',
    },
  }
}
