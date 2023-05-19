return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    local cfg = require "config"
    cfg.keymaps["<leader>dd"] = { "<cmd>Neotree toggle<cr>", "Open files exporer" }
    cfg.keymaps["<leader>df"] = { "<cmd>Neotree reveal<cr>", "Locate the current File" }
    cfg.keymaps["<leader>ds"] =
      { "<cmd>Neotree document_symbols position=right<cr>", "Locate the current File" }
    cfg.keymaps["<leader>db"] =
      { "<cmd>Neotree toggle source=buffers<cr>", "Open buffers explorer" }
  end,
  opts = {
    sources = {
      "filesystem",
      "buffers",
      -- "git_status",
      "document_symbols",
    },
    window = {
      mappings = {
        ["o"] = "toggle_node",
        ["<c-x>"] = "open_split",
        ["<c-v>"] = "open_vsplit",
      },
    },
    document_symbols = {
      follow_cursor = true,
    },
  },
}
