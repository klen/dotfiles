-- Snippet Engine for Neovim written in Lua
-- https://github.com/L3MON4D3/LuaSnip

local ok, plug = pcall(require, "luasnip")
if not ok then
  return
end

local types = require "luasnip.util.types"

plug.config.set_config {
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

-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if plug.expand_or_jumpable() then
    plug.expand_or_jump()
  end
end, { silent = true })

-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if plug.jumpable(-1) then
    plug.jump(-1)
  end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
  if plug.choice_active() then
    plug.change_choice(1)
  end
end)

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

-- Load snippets from vscode
require("luasnip/loaders/from_vscode").lazy_load()
