vim.pack.add({
  "https://github.com/pablopunk/pi.nvim"
})

-- pi.nvim: AI coding agent inside Neovim
require('pi').setup({
  context = {
    max_bytes = 262000, -- 256KB cap to keep requests fast
  }
})

-- Prefix keymap for all pi AI commands
vim.keymap.set("n", "<leader>a", "", { desc = "+ai" })

-- Ask pi with the current buffer as context
vim.keymap.set("n", "<leader>ai", ":PiAsk<CR>", { desc = "Ask pi" })

-- Ask pi with visual selection as context
vim.keymap.set("v", "<leader>ai", ":PiAskSelection<CR>", { desc = "Ask pi (selection)" })

-- Open the pi request/response log
vim.keymap.set("n", "<leader>al", ":PiLog<CR>", { desc = "Show pi log" })

-- Abort the currently running pi request
vim.keymap.set("n", "<leader>ac", ":PiCancel<CR>", { desc = "Cancel pi request" })
