-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "m",
  Module = "",
  Operator = "",
  Property = "",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP completion
    "hrsh7th/cmp-buffer",   -- Buffer completion
    "hrsh7th/cmp-path",     -- Path completion
    "hrsh7th/cmp-nvim-lua", -- VIM lua API completion
    -- "saadparwaiz1/cmp_luasnip", -- Snippets completion
  },
  opts = function()
    local cmp = require "cmp"

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      -- snippet = {
      --   expand = function(args)
      --     require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      --   end,
      -- },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-c>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
      },
      sources = {
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        { name = "buffer",  keyword_length = 5 },
        { name = "path" },
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[lsp]",
            -- luasnip = "[snippet]",
            buffer = "[buffer]",
            path = "[path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
    }
  end,
}
