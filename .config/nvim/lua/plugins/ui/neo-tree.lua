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
      icon = {
        provider = function(icon, node) -- setup a custom icon provider
          local text, hl
          local mini_icons = require("mini.icons")
          if node.type == "file" then          -- if it's a file, set the text/hl
            text, hl = mini_icons.get("file", node.name)
          elseif node.type == "directory" then -- get directory icons
            text, hl = mini_icons.get("directory", node.name)
            -- only set the icon text if it is not expanded
            if node:is_expanded() then
              text = nil
            end
          end

          -- set the icon text/highlight only if it exists
          if text then
            icon.text = text
          end
          if hl then
            icon.highlight = hl
          end
        end,
      },
      kind_icon = {
        provider = function(icon, node)
          local mini_icons = require("mini.icons")
          icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
        end,
      },
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
        ["<C-x>"] = "open_split",
        ["<C-v>"] = "open_vsplit",
        ['/'] = "noop",
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
