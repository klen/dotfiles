local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end
local u = require "utils"
local actions = require "telescope.actions"

local config = {

  defaults = {
    path_display = { shorten = 5 },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {
      i = {
        ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
        ["<esc>"] = actions.close,
      },
    },
  },

  pickers = {
    find_files = { theme = "dropdown" },
    oldfiles = { theme = "dropdown" },
    treesitter = { theme = "dropdown" },
    git_files = { theme = "dropdown" },
    buffers = { theme = "dropdown" },
    lsp_code_actions = { theme = "cursor" },
    colorscheme = {
      theme = "dropdown",
      enable_preview = true,
    },
  },

  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    dash = {
      dash_app_path = "/Applications/Dash4.app",
    },
  },
}
telescope.load_extension "fzf"
telescope.load_extension "projects"
telescope.setup(config)

u.nmap("<C-Space>", ":Telescope<CR>")
u.lua_command("Config", "require'utils/telescope'.config()")
u.lua_command("Files", "require'telescope.builtin'.git_files()")
