-- Snippets

return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  opts = function()
    local types = require "luasnip.util.types"
    vim.print "luasnip loaded"

    return {

      -- This tells LuaSnip to remember to keep around the last snippet.
      -- You can jump back into it even if you move outside of the selection
      history = true,

      -- This one is cool cause if you have dynamic snippets, it updates as you type!
      updateevents = "TextChanged,TextChangedI",

      -- Autosnippets:
      enable_autosnippets = true,

      -- Crazy highlights!!
      -- #vid3
      -- ext_opts = nil,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { " <- Current Choice", "NonTest" } },
          },
        },
      },
    }
  end,

  keys = {
    -- this will expand the current item or jump to the next item within the snippet.
    {
      "<c-k>",
      function()
        local snip = require "luasnip"
        if snip.expand_or_jumpable() then
          -- snip.expand_or_jump()
          return "<Plug>luasnip-expand-or-jump" or "<c-k>"
        end
      end,
      expr = true,
      silent = true,
      mode = { "i", "s" },
    },
    -- this always moves to the previous item within the snippet
    {
      "<c-j>",
      function()
        local snip = require "luasnip"
        if snip.jumpable(-1) then
          snip.jump(-1)
        end
      end,
      silent = true,
      mode = { "i", "s" },
    },
    -- <c-l> is selecting within a list of options.
    {
      "<c-l>",
      function()
        local snip = require "luasnip"
        if snip.choice_active() then
          snip.change_choice(1)
        end
      end,
      mode = "i",
    },
    {
      "<c-u>",
      function()
        local select_choice = require "luasnip.extras.select_choice"
        select_choice()
      end,
      mode = "i",
    },
  },
}
