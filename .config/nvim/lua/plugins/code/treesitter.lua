-- TreeSitter (syntax, folding)

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },

    -- Setup the plugin
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "bash",
          "c",
          "cmake",
          "comment",
          "css",
          "dockerfile",
          "go",
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "json5",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "rst",
          "ruby",
          "rust",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = {},
          -- additional_vim_regex_highlighting = { "markdown" },
        },
        indent = {
          enable = true,
          disable = { "python", "rust" },
        },
        matchup = {
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
    end,

    init = function()
      vim.opt.foldlevel = 99
      vim.api.nvim_create_augroup("treesitter", { clear = true })
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        command = "set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
        group = "treesitter",
      })
      vim.keymap.set("n", "gm", ":TSHighlightCapturesUnderCursor<CR>")
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "nvim-treesitter/playground",
    cmd = {
      "TSPlaygroundToggle",
      "TSHighlightCapturesUnderCursor",
    },
  },
}
