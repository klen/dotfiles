-- https://github.com/zbirenbaum/copilot.lua

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = false, -- Managed by blink-cmp
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-e>",
      },
    },
    panel = {
      enabled = false, -- Disable the default panel
    },
    filetypes = {
      help = true,
      markdown = true,
    },
  },
  init = function()
    vim.api.nvim_create_augroup("copilot", { clear = true })

    -- Automatically dismiss Copilot suggestions when leaving Insert mode
    vim.api.nvim_create_autocmd("InsertLeave", {
      pattern = "*",
      group = "copilot",
      callback = function()
        require("copilot.suggestion").dismiss()
      end,
    })
  end,
}
