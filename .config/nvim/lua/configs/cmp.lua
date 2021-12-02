-- Setup hrsh7th/nvim-cmp
--
local cmp = require "cmp"

local luasnip = require "luasnip"
local M = {}

M.config = {
  confirm_opts = {
    select = true,
    behavior = cmp.ConfirmBehavior.Replace,
  },
  completion = {
    ---@usage The minimum length of a word to complete on.
    keyword_length = 1,
    autocomplete = false,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  formatting = {
    source_names = {
      nvim_lsp = "(LSP)",
      emoji = "(Emj)",
      path = "(Pth)",
      calc = "(Clc)",
      cmp_tabnine = "(Tb9)",
      vsnip = "(Snp)",
      luasnip = "(Snp)",
      buffer = "(Buf)",
    },
    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },
    duplicates_default = 0,
    format = function(entry, vim_item)
      vim_item.menu = M.config.formatting.source_names[entry.source.name]
      vim_item.dup = M.config.formatting.duplicates[entry.source.name]
        or M.config.formatting.duplicates_default
      return vim_item
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "buffer" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-c>"] = cmp.mapping.abort(),
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.confirm(M.config.confirm_opts) then
        if luasnip.jumpable() then
          luasnip.jump(1)
        end
        return
      end
      -- if luasnip.jumpable() and luasnip.jump(1) then
      --   return
      -- end
      fallback()
    end),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable() then
        luasnip.jump(1)
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
        -- elseif luasnip.jumpable() then
        --   luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
}

cmp.setup(M.config)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })