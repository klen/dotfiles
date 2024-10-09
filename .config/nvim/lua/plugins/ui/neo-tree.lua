-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    local cfg = require "config"
    table.insert(
      cfg.keymaps,
      { "<leader>dd", "<cmd>Neotree toggle<cr>", desc = "Open files exporer" }
    )
    table.insert(
      cfg.keymaps,
      { "<leader>df", "<cmd>Neotree reveal<cr>", desc = "Locate the current File" }
    )
    table.insert(
      cfg.keymaps,
      { "<leader>dg", "<cmd>Neotree git_status reveal<cr>", desc = "Show git status" }
    )
    table.insert(
      cfg.keymaps,
      { "<leader>ds", "<cmd>Neotree document_symbols reveal<cr>", desc = "Toggle document symbols" }
    )
    table.insert(cfg.keymaps, {
      "<leader>dh",
      "<cmd>Neotree toggle source=filesystem hidden<cr>",
      desc = "Toggle hidden files",
    })

    vim.g.neo_tree_remove_legacy_commands = 1
  end,
  opts = {
    default_component_configs = {
      -- icon = {
      --   enabled = false,
      -- },
    },
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    window = {
      mappings = {
        ["o"] = "toggle_node",
        ["<c-x>"] = "open_split",
        ["<c-v>"] = "open_vsplit",
        ["/"] = "noop",
      },
    },
    document_symbols = {
      follow_cursor = true,
      window = {
        position = "right",
      },
    },
    filesystem = {
      window = {
        mappings = {
          ["I"] = "toggle_hidden",
        },
      },
    },
  },
}
