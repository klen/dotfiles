local tools = require "tools"
local api = vim.api
local keymap = vim.keymap

-- Navigation
keymap.set("n", "k", "gk")
keymap.set("n", "j", "gj")
keymap.set("n", "<left>", ":cprev<cr>zvzz") -- quickfix
keymap.set("n", "<right>", ":cnext<cr>zvzz")
keymap.set("n", "<up>", ":lprev<cr>zvzz")   -- loclist
keymap.set("n", "<down>", ":lnext<cr>zvzz")

-- Insert mode shortcuts
keymap.set("i", "<C-o>", "<Esc>o")
keymap.set("i", "<C-j>", "<Esc>J")

-- Not jump on star, only highlight
keymap.set("n", "*", "*N")

-- Keep it centered
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "J", "mzJ`z")

-- Save file
keymap.set("n", "<CR>", ":w<CR>")
-- Fast save
keymap.set("n", "<S-CR>", tools.fast_save)

-- Toggle keymap
keymap.set("n", "<C-F>", "a<C-^><Esc>")
keymap.set("i", "<C-F>", "<C-^>")
keymap.set("v", "<C-F>", "<Esc>a<C-^><Esc>gv")

-- Command mode
keymap.set("c", "<C-A>", "<Home>")
keymap.set("c", "<C-E>", "<End>")

-- Paste relaces visual selection do not copy it
keymap.set("v", "p", '"_dP')

-- Disable ex mode (format lines insted)
keymap.set("n", "Q", "gq")

-- Terminal mode
keymap.set("t", "<Esc>", "<C-\\><C-n>")
-- keymap.set("t", "<C-[>", "<C-\\><C-n>")

--  Commands
--  --------

api.nvim_create_user_command("Reset", "write | :edit", { nargs = 0 })
api.nvim_create_user_command("Remove", "call delete(expand('%')) | bdelete", { nargs = 0 })
api.nvim_create_user_command("Make", "vsplit | :terminal make <args>", { nargs = "?" })
api.nvim_create_user_command("Dashboard", function()
  MiniStarter.open(0)
end, { nargs = 0 })
api.nvim_create_user_command("Reload", function(args)
  tools.reload(args.args)
end, { nargs = 1 })

-- Plugins
local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

-- Helpers
keymap.set("n", "<leader>on", tools.toggle_number)
keymap.set("n", "gw", tools.vimgrep)
keymap.set("n", "gM", tools.synstack)

wk.add {
  -- Find something
  { "<leader>f",  group = "find" },

  -- Plugins
  { "<leader>p",  group = "plugins" },

  -- Explore
  { "<leader>d",  group = "explore" },
  { "<leader>dt", "<cmd>bo vsplit | terminal<cr>",   desc = "Open terminal" },
  { "<leader>dl", "<cmd>lopen<cr>",                  desc = "Open loclist" },
  { "<leader>dq", "<cmd>copen<cr>",                  desc = "Open quickfix" },

  -- Git (fugitive)
  { "<leader>g",  group = "git" },
  { "<leader>gh", "<cmd>!gh browse<cr>",             desc = "Browse current repo" },

  -- Windows
  { "<leader>h",  "<cmd>wincmd h<cr>",               desc = "Go to the left window" },
  { "<leader>j",  "<cmd>wincmd j<cr>",               desc = "Go to the down window" },
  { "<leader>k",  "<cmd>wincmd k<cr>",               desc = "Go to the up window" },
  { "<leader>l",  "<cmd>wincmd l<cr>",               desc = "Go to the right window" },
  { "<leader>c",  group = "close window" },
  { "<leader>ch", "<cmd>wincmd h<cr><cmd>close<cr>", desc = "Close the left window" },
  { "<leader>cj", "<cmd>wincmd j<cr><cmd>close<cr>", desc = "Close the down window" },
  { "<leader>ck", "<cmd>wincmd k<cr><cmd>close<cr>", desc = "Close the up window" },
  { "<leader>cl", "<cmd>wincmd l<cr>close<cr>",      desc = "Close the right window" },
  { "<leader>cc", "<cmd>close<cr>",                  desc = "Close the current window" },
  { "<leader>r",  group = "resize window" },
  { "<leader>rk", "<cmd>resize -5<cr>",              desc = "Expand window up" },
  { "<leader>rj", "<cmd>resize +5<cr>",              desc = "Expand window bellow" },
  { "<leader>rl", "<C-W>5>",                         desc = "Expand window right" },
  { "<leader>rh", "<C-W>5<",                         desc = "Expand window left" },

  -- Tests (vim-test)
  { "<leader>t",  group = "tests" },

  -- Buffers
  { "<leader>b",  group = "buffers" },
  {
    "<leader>bd",
    "<cmd>bdelete<cr>",
    desc = "Delete the current buffer",
  },
  { "<leader>bn", "<cmd>bnext<cr>", desc = "Go to the next buffer" },
  { "<Tab>",      "<cmd>bnext<cr>", desc = "Go to the next buffer" },
  { "<S-Tab>",    "<cmd>bnext<cr>", desc = "Go to the next buffer" },
  {
    "<leader>bp",
    "<cmd>bprev<cr>",
    desc = "Go to the previous buffer",
  },

  -- Options
  { "<leader>o",  group = "options" },
  { "<leader>ol", "<cmd>set list! list?<cr>", desc = "Toggle &list" },
  { "<leader>ow", "<cmd>set wrap! wrap?<cr>", desc = "Toggle &wrap" },
  { "<leader>on", tools.toggle_number },
  {
    "<leader>os",
    "<cmd>set invhlsearch<cr>",
    desc = "Toggle highlight for search results",
  },

  -- Other
  { "gw", desc = "Grep current word" },
  { "gI", "`.",                                           desc = "Go to the last edit" },
  { "gk", "k",                                            desc = "Up" },
  { "gj", "j",                                            desc = "Down" },
  { "gM", desc = "Show synstack for the current position" },
}

local cfg = require "config"
wk.add(cfg.keymaps)
