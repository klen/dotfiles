-- A completion plugin for neovim coded in Lua.
-- https://github.com/hrsh7th/nvim-cmp
return {
  "hrsh7th/nvim-cmp",
  requires = { "L3MON4D3/LuaSnip" },
  config = function()
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
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
        -- ["<CR>"] = cmp.mapping(function(fallback)
        --   if cmp.visible() and cmp.confirm(M.config.confirm_opts) then
        --     if luasnip.jumpable() then
        --       luasnip.jump(1)
        --     end
        --     return
        --   end
        --   fallback()
        -- end),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
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
  end,
}
