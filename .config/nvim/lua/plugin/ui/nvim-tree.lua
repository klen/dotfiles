-- A file explorer tree for neovim written in lua
-- https://github.com/kyazdani42/nvim-tree.lua
return {
  "kyazdani42/nvim-tree.lua",
  cmd = {
    "NvimTreeOpen",
    "NvimTreeFocus",
    "NvimTreeToggle",
    "NvimTreeFindFile",
  },
  setup = function()
    local cfg = require "config"
    cfg.keymaps["<leader>dd"] = { "<cmd>NvimTreeFocus<cr>", "Open/focus Explorer" }
    cfg.keymaps["<leader>df"] = { "<cmd>NvimTreeFindFile<cr>", "Locate File" }
  end,
  config = function()
    local nvimtree = require "nvim-tree"

    local tree_cb = require("nvim-tree.config").nvim_tree_callback
    nvimtree.setup {
      open_on_setup = true, -- open if empty or directory
      ignore_ft_on_setup = { "dashboard" }, -- ignore file types
      hijack_cursor = true, -- keeps the cursor on the first letter of the filename
      view = {
        mappings = {
          list = {
            { key = "I", cb = tree_cb "toggle_dotfiles" },
            { key = "f", cb = tree_cb "toggle_git_ignored" },
            { key = "C", cb = tree_cb "cd" },
            { key = "md", cb = tree_cb "remove" },
            { key = "mm", cb = tree_cb "rename" },
            { key = "ma", cb = tree_cb "create" },
          },
        },
      },
      renderer = {
        highlight_git = false,
        highlight_opened_files = "name",
        icons = {
          show = {
            git = false,
            folder = true,
            file = false,
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            chars = "KJABCDEFGHILMNOPQRSTUVWXYZ1234567890J",
            exclude = {
              filetype = {
                "Outline",
                "SidebarNvim",
                "notify",
                "packer",
                "qf",
              },
              buftype = {
                "terminal",
              },
            },
          },
        },
      },
      filters = {
        dotfiles = true,
        custom = { "__mocks__", "__snapshots__", ".DS_Store" },
      },
    }

    cmd [[ hi! link NvimTreeSpecialFile Special ]]
    cmd [[ hi! link NvimTreeRootFolder Statement ]]
    cmd [[ hi! link NvimTreeFolderName Directory ]]
    cmd [[ hi! link NvimTreeSymlink Macro ]]
    cmd [[ hi! link NvimTreeOpenedFolderName Identifier ]]
  end,
}
