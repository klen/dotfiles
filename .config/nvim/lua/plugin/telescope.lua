-- Find, Filter, Preview, Pick. All lua, all the time.
-- https://github.com/nvim-telescope/telescope.nvim
return {
  "nvim-telescope/telescope.nvim",
  config = function()
    local telescope = require "telescope"

    local tools = require "tools"
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
        buffers = { theme = "dropdown" },
        find_files = { theme = "dropdown" },
        git_files = { theme = "dropdown" },
        lsp_code_actions = { theme = "cursor" },
        neoclip = { theme = "dropdown" },
        oldfiles = { theme = "dropdown" },
        treesitter = { theme = "dropdown" },
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
    -- projects.nvim
    -- telescope.load_extension "projects"
    telescope.setup(config)

    telescope.load_extension "fzf"
    telescope.load_extension "neoclip"

    tools.nmap("<C-Space>", ":Telescope<CR>")
    tools.lua_command("Files", "require'telescope.builtin'.git_files()")
  end,
}
