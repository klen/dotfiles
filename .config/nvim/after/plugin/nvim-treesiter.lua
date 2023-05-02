-- Nvim Treesitter configurations and abstraction layer
-- https://github.com/nvim-treesitter/nvim-treesitter
local ok, plug = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

vim.opt.foldlevel = 99
vim.api.nvim_create_augroup("treesitter", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  command = "set foldmethod=expr foldexpr=nvim_treesitter#foldexpr()",
  group = "treesitter",
})
vim.keymap.set("n", "gm", ":TSHighlightCapturesUnderCursor<CR>")

plug.setup {
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
