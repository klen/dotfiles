return {

  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  version = false,
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    -- Configure previewer
    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function()
        vim.wo.wrap = true
        vim.wo.linebreak = true
        vim.wo.list = false
      end,
    })

    telescope.setup {
      defaults = {
        path_display = { shorten = 5 },
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        mappings = {
          i = {
            ["<C-l>"] = actions.send_to_loclist + actions.open_loclist,
            ["<C-h>"] = actions.which_key,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-Down>"] = actions.cycle_history_next,
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
    }
  end,
  keys = {
    { "<leader>fm", "<cmd>Telescope keymaps<cr>",      desc = "Find keymaps" },
    { "<leader>gl", "<cmd>Telescope git_bcommits<cr>", desc = "Git log file" },
    { "<leader>gL", "<cmd>Telescope git_commits<cr>",  desc = "Git log" },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_workspace_symbols {
          query = vim.fn.input "Query: ",
          symbols = { "Class", "Function", "Method" },
        }
      end,
      desc = "Goto Symbol (workspace)",
    },
  },
}
