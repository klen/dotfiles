-- Neo-tree is a Neovim plugin to browse the file system and other tree like structures
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>e",
      ":Neotree toggle<CR>",
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
    {
      "<leader>fs",
      ":Neotree document_symbols toggle<CR>",
      desc = "Document Symbols",
    },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      sources = {
        { source = "filesystem", display_name = "Files" },
        { source = "buffers", display_name = "Buffers" },
        { source = "git_status", display_name = "Git" },
        { source = "document_symbols", display_name = "Code" },
      },
    },
    enable_git_status = false,
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
        ["l"] = "open",
        ["<cr>"] = function(state)
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
    document_symbols = {
      window = {
        mappings = {
          ["<C-r>"] = "noop",
        },
      },
    },
  },
}
