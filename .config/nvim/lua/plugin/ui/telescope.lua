-- Find, Filter, Preview, Pick. All lua, all the time.
-- https://github.com/nvim-telescope/telescope.nvim
return {
  "nvim-telescope/telescope.nvim",

  config = function()
    local telescope = require "telescope"

    local actions = require "telescope.actions"

    local config = {
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
    -- projects.nvim
    -- telescope.load_extension "projects"

    telescope.setup(config)

    -- telescope.load_extension "fzf"
  end,

  setup = function()
    local tools = require "tools"
    tools.nmap("<C-Space>", ":Telescope<CR>")
    tools.lua_command("Files", "require'telescope.builtin'.git_files()")

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
  end,
}
