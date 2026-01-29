-- Neo-tree is a Neovim plugin to browse the file system and other tree like structures
return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "Explorer NeoTree (Toggle)",
    },
    {
      "<leader>fe",
      function()
        local cmd = require("neo-tree.command")
        local nofile = vim.bo.buftype == "nofile"

        cmd.execute({ toggle = nofile, reveal = not nofile })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
  },
  opts = {
    default_component_configs = {
      icon = {
        enabled = false,
      },
    },
    window = {
      mappings = {
        ["o"] = "toggle_node",
        ["<C-s>"] = "open_split",
        ["<C-v>"] = "open_vsplit",
        ["/"] = "noop",
        ["<cr>"] = "open",
        ["l"] = function(state)
          ---@diagnostic disable-next-line
          require("neo-tree.sources.common.commands").open(state)
          require("neo-tree.command").execute({ action = "close" })
        end,
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
