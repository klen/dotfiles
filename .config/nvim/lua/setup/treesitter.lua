local ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end
local u = require "utils"

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

u.nmap("gm", ":TSHighlightCapturesUnderCursor<CR>")

cmd [[
  autocmd BufEnter * set foldmethod=expr
  autocmd BufEnter * set foldexpr=nvim_treesitter#foldexpr()
  set foldlevel=99
]]
