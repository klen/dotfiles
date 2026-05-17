-- Install
vim.pack.add({
  "https://github.com/zbirenbaum/copilot.lua"
})

-- Setup
require('copilot').setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_automatically = false,
    hide_during_completion = false,
    keymap = {
      accept = false,
      accept_word = false,
      accept_line = false,
      next = "<C-n>",
      prev = "<C-p>",
      dismiss = "<C-c>"
    }
  },
  panel = { enabled = false },
}

vim.keymap.set('i', '<C-y>', function()
  -- if completion menu is visible, accept the completion
  if vim.fn.pumvisible() == 1 then
    -- if no entry is selected, select the first one and accept it
    local info = vim.fn.complete_info({ "selected" })
    if info.selected == -1 then
      return "<C-n><C-y>"
    end

    return "<C-y>"
  end

  -- if copilot suggestion is visible, accept it
  return require('copilot.suggestion').accept()
end, { silent = true, expr = true })

local utils = require("utils")

-- Automatically dismiss Copilot suggestions when leaving Insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  group = utils.autogroup('copilot'),
  callback = function()
    require("copilot.suggestion").dismiss()
  end,
})
