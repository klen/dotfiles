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
}
