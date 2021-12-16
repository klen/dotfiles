return {

  -- Treesitter helpers
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufEnter",
    cmd = {
      "TSInstall",
      "TSInstallSync",
      "TSBufEnable",
      "TSBufToggle",
      "TSEnableAll",
      "TSInstallFromGrammer",
      "TSToggleAll",
      "TSUpdate",
      "TSUpdateSync",
    },
    config = function()
      local nvim_treesitter = require "nvim-treesitter.configs"
      local utils = require "utils"

      nvim_treesitter.setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          custom_captures = {
            ["python.field"] = "Identifier",
            ["python.variable"] = "Identifier",
          },
        },
        matchup = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { "python" },
        },
        autotag = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = false,
            -- swap_next = {
            --   ["<leader>a"] = "@parameter.inner",
            -- },
            -- swap_previous = {
            --   ["<leader>A"] = "@parameter.inner",
            -- },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      }

      vim.opt.foldlevel = 99
      utils.nmap("gm", ":TSHighlightCapturesUnderCursor<CR>")
      utils.au("BufEnter", "*", "set foldmethod=expr")
      utils.au("BufEnter", "*", "set foldexpr=nvim_treesitter#foldexpr()")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- Debug
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
    },
  },
}
