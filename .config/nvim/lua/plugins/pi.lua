vim.pack.add({
  "https://github.com/pablopunk/pi.nvim"
})

local pi_ok, pi = pcall(require, 'pi')
if not pi_ok then
  vim.notify("pi.nvim plugin not found!", vim.log.levels.WARN)
  return
end

-- pi.nvim: AI coding agent inside Neovim
pi.setup({
  context = {
    max_bytes = 262000, -- 256KB cap to keep requests fast
  }
})

-- Prefix keymap for all pi AI commands
vim.keymap.set("n", "<leader>a", "", { desc = "+ai" })

-- Ask pi with the current buffer as context
vim.keymap.set("n", "<leader>ai", function()
  pi.prompt_with_buffer()
end, { desc = "Ask pi with current buffer" })

-- Ask pi with visual selection as context
vim.keymap.set("v", "<leader>ai", function()
  pi.prompt_with_selection()
end, { desc = "Ask pi (selection)" })

-- Open the pi request/response log
vim.keymap.set("n", "<leader>al", function()
  pi.show_log()
end, { desc = "Show pi log" })

-- Abort the currently running pi request
vim.keymap.set("n", "<leader>ac", function()
  pi.cancel()
end, { desc = "Cancel pi request" })
