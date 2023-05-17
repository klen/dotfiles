-- A completion plugin for neovim coded in Lua
-- https://github.com/hrsh7th/nvim-cmp
--
local ok, plug = pcall(require, "cmp")
if not ok then
  return
end

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

plug.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-d>"] = plug.mapping.scroll_docs(-4),
    ["<C-f>"] = plug.mapping.scroll_docs(4),
    ["<C-c>"] = plug.mapping.close(),
    ["<C-n>"] = plug.mapping.select_next_item(),
    ["<C-p>"] = plug.mapping.select_prev_item(),
    ["<C-Space>"] = plug.mapping(plug.mapping.complete(), { "i", "c" }),
    ["<CR>"] = plug.mapping.confirm { select = true },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
    { name = "path" },
  },
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = ({
        nvim_lsp = "[lsp]",
        luasnip = "[snippet]",
        buffer = "[buffer]",
        path = "[path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  confirm_opts = {
    behavior = plug.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}
