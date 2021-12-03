g.nvim_tree_gitignore = 1 -- Ignore files from .gitignore
g.nvim_tree_show_icons = { git = 0, folders = 1, files = 0 } -- Show icons
g.nvim_tree_highlight_opened_files = 2
g.nvim_tree_git_hl = 0 -- Will enable file highlight for git attributes
g.nvim_tree_indent_markers = 0 -- This option shows indent markers when folders are open.
g.nvim_tree_disable_window_picker = 0
g.nvim_tree_window_picker_chars = "KJABCDEFGHILMNOPQRSTUVWXYZ1234567890J"
vim.g.nvim_tree_window_picker_exclude = {
  filetype = {
    "notify",
    "packer",
    "qf",
    "minimap",
    "Outline",
  },
  buftype = {
    "terminal",
  },
}

local present, nvimtree = pcall(require, "nvim-tree")
if not present then
  return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback
nvimtree.setup {
  open_on_setup = true, -- open if empty or directory
  ignore_ft_on_setup = { "dashboard" }, -- ignore file types
  hijack_cursor = true, -- keeps the cursor on the first letter of the filename
  update_cwd = true,
  update_focused_file = {
    enable = false,
    update_cwd = true,
  },
  diagnostics = {
    enable = false,
  },
  view = {
    width = 30,
    side = "left",
    auto_resize = true,
    mappings = {
      list = {
        { key = "I", cb = tree_cb "toggle_dotfiles" },
        { key = "f", cb = tree_cb "toggle_ignored" },
        { key = "?", cb = tree_cb "toggle_help" },
        { key = "C", cb = tree_cb "cd" },
        { key = "md", cb = tree_cb "remove" },
        { key = "mm", cb = tree_cb "rename" },
        { key = "ma", cb = tree_cb "create" },
      },
    },
  },
  filters = {
    dotfiles = true,
    custom = {
      "dist",
      "build",
      "__pycache__",
      "node_modules",
      "*.lock",
      "*.egg-*",
      ".cache",
      ".git",
    },
  },
}

cmd [[ hi! link NvimTreeSpecialFile Special ]]
cmd [[ hi! link NvimTreeRootFolder Statement ]]
cmd [[ hi! link NvimTreeFolderName Directory ]]
cmd [[ hi! link NvimTreeSymlink Macro ]]
cmd [[ hi! link NvimTreeOpenedFolderName Identifier ]]
