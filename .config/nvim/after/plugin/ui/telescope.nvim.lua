-- Find, Filter, Preview, Pick. All lua, all the time.
-- https://github.com/nvim-telescope/telescope.nvim
--
local ok, plug = pcall(require, "telescope")
if not ok then
  return
end

local actions = require "telescope.actions"
plug.setup {
  defaults = {
    path_display = { shorten = 5 },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {
      i = {
        ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
        ["<C-h>"] = actions.which_key,
        ["<esc>"] = actions.close,
      },
    },
  },

  pickers = {
    buffers = { theme = "dropdown" },
    find_files = { theme = "dropdown" },
    git_files = { theme = "dropdown" },
    help_tags = { theme = "dropdown" },
    lsp_code_actions = { theme = "cursor" },
    oldfiles = { theme = "dropdown" },
    treesitter = { theme = "dropdown" },
    colorscheme = {
      theme = "dropdown",
      enable_preview = true,
    },
  },

  extensions = {
    -- fzf = {
    --   fuzzy = true,
    --   override_generic_sorter = true,
    --   override_file_sorter = true,
    --   case_mode = "smart_case",
    -- },
    -- dash = {
    --   dash_app_path = "/Applications/Dash4.app",
    -- },
  },
}

vim.keymap.set("n", "<C-Space>", "<cmd>Telescope<CR>")

local cfg = require "config"
cfg.keymaps["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find Files" }
cfg.keymaps["<leader>fg"] = { "<cmd>Telescope git_files<cr>", "Find Git Files" }
cfg.keymaps["<leader>fw"] = { "<cmd>Telescope live_grep<cr>", "Find a word" }
cfg.keymaps["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Find recent files" }
cfg.keymaps["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Find buffers" }
cfg.keymaps["<leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Search in help files" }
cfg.keymaps["<leader>fc"] = { "<cmd>Telescope command_history<cr>", "Command history" }
cfg.keymaps["<leader>fs"] = {
  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
  "Search workspace symbols",
}
cfg.keymaps["<leader>gl"] = { "<cmd>Telescope git_bcommits<cr>", "Git log file" }
cfg.keymaps["<leader>gL"] = { "<cmd>Telescope git_commits<cr>", "Git log" }
