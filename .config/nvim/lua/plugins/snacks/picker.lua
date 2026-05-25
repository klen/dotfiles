local map = vim.keymap.set
local picker = require("snacks.picker")

map("n", "<leader><space>", function() picker.files() end, { desc = "Find files" })
map("n", "<leader>/", function() picker.grep() end, { desc = "Grep word" })

map('n', '<leader>f', '', { desc = "+find" }) -- Prefix for find commands
map("n", "<leader>fb", function() picker.buffers() end, { desc = "Find buffers" })
map("n", "<leader>fn", function() picker.notifications() end, { desc = "Find notifications" })
map("n", "<leader>fh", function() picker.help() end, { desc = "Find help tags" })
map('n', '<leader>fw', function() picker.grep_word() end, { desc = "Grep word under cursor" })
map('n', '<leader>fm', function() picker.keymaps() end, { desc = "Find keymaps" })
map('n', '<leader>fc', function() picker.highlights() end, { desc = "Find highlights" })
map("n", "<leader>fr", function() picker.recent() end, { desc = "Find recent files" })

map('n', '<leader>gl', function() picker.git_log_file() end, { desc = "Git commits (file)" })
map('n', '<leader>gL', function() picker.git_log() end, { desc = "Git commits (project)" })

map("n", "<leader>fl", function() picker.lsp_workspace_symbols() end, { desc = "Find LSP symbols" })

return {
  win = {
    input = {
      keys = {
        ["<C-j>"] = { "focus_list", mode = { "i", "n" } },
        ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
      },
    },
    list = {
      keys = {
        ["<C-c>"] = { "close", mode = { "i", "n" } },
        ["<C-k>"] = { "focus_input", mode = { "i", "n" } },
        ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
      },
    },
    preview = {
      keys = {
        ["<C-c>"] = { "close", mode = { "i", "n" } },
        ["<C-h>"] = { "focus_input", mode = { "i", "n" } },
      },
      wo = {
        wrap = true,
      },
    },
  },
  icons = {
    files = {
      enabled = false,
    },
    git = {
      enabled = false,
    },
  },

}
