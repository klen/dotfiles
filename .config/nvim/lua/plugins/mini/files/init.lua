local miniFiles = require "mini.files"
local utils = require "plugins.mini.files.utils"

-- Setup
miniFiles.setup {
  mappings = {
    synchronize = "<CR>",
  },
  content = {
    filter = utils.filter_dotfiles,
  },
}

-- Keymaps
vim.keymap.set("n", "<leader>ff", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
  miniFiles.open(path)
  miniFiles.reveal_cwd()
end, { desc = "File browser (current)" })

vim.keymap.set("n", "<leader>fe", function()
  miniFiles.open(nil, false)
end, { desc = "File browser (root)" })

-- Autocmds
-- Bind keys
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id

    -- Toggle showing dotfiles
    vim.keymap.set(
      "n",
      "<M-h>",
      utils.toggle_dotfiles,
      { buffer = buf_id, desc = "Toggle dotfiles" }
    )

    -- Split window and open file in it, then close explorer
    utils.map_split(buf_id, "<C-s>", "belowright horizontal")
    utils.map_split(buf_id, "<C-v>", "belowright vertical")
    utils.map_split(buf_id, "<C-t>", "tab")
  end,
})

-- Window position
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowUpdate",
  callback = function(args)
    local win_id = args.data.win_id
    local config = vim.api.nvim_win_get_config(win_id)
    config.anchor = "SW"
    config.row = vim.o.lines - vim.o.cmdheight - 1
    vim.api.nvim_win_set_config(win_id, config)
  end,
})
