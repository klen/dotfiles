local tools = require "tools"

g.mapleader = ","
g.maplocalleader = " "

-- Navigation
tools.nmap("j", "gj")
tools.nmap("k", "gk")
tools.nmap("<left>", ":cprev<cr>zvzz") -- quickfix
tools.nmap("<right>", ":cnext<cr>zvzz")
tools.nmap("<up>", ":lprev<cr>zvzz") -- loclist
tools.nmap("<down>", ":lnext<cr>zvzz")

-- Automatically jump to end of text you pasted
tools.nmap("p", "p`]")
tools.vmap("p", "p`]")
tools.vmap("y", "y`]")

-- Not jump on star, only highlight
tools.nmap("*", "*N")

-- Keep it centered
tools.nmap("n", "nzzzv")
tools.nmap("N", "Nzzzv")
tools.nmap("J", "mzJ`z")

-- Save file
tools.nmap("<CR>", ":w<CR>")
-- Fast save
tools.nmap("<S-CR>", "lua require'tools.helpers'.fast_save()<CR>")

-- Toggle keymap
tools.nmap("<C-F>", "a<C-^><Esc>")
tools.imap("<C-F>", "<C-^>")
tools.vmap("<C-F>", "<Esc>a<C-^><Esc>gv")

-- Command mode
tools.cmap("<C-A>", "<Home>", { silent = false })
tools.cmap("<C-E>", "<End>", { silent = false })

-- Paste relaces visual selection do not copy it
tools.vmap("p", '"_dP')

-- Disable ex mode (format lines insted)
tools.nmap("Q", "gq")

-- Terminal mode
tools.tmap("<C-[>", "<C-\\><C-n>")

--  Commands
--  --------

tools.command("-nargs=0 Reset", "write | :edit")
tools.command("-nargs=0 Remove", "call delete(expand('%')) | bdelete")
tools.command("-nargs=? Make", "vsplit | :terminal make <args>")
tools.lua_command("Dashboard", "MiniStarter.open()")
tools.lua_command("-nargs=1 Reload", "require'tools'.reload(fn.expand('<args>'))")

-- Plugins
local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

wk.register {

  -- Find something
  ["<leader>f"] = { name = "+find" },

  -- Plugins
  ["<leader>p"] = { name = "+plugins" },

  -- Explore
  ["<leader>d"] = { name = "+explore" },
  ["<leader>dt"] = { "<cmd>bo vsplit | terminal<cr>", "Open terminal" },
  ["<leader>dl"] = { "<cmd>lopen<cr>", "Open loclist" },
  ["<leader>dq"] = { "<cmd>copen<cr>", "Open quickfix" },

  -- Git (fugitive)
  ["<leader>g"] = { name = "+git" },
  ["<leader>gh"] = { "<cmd>!gh browse<cr>", "Browse current repo" },

  -- Comments
  ["gcc"] = { "Comment/uncomment line" },

  -- Windows
  ["<leader>h"] = { "<cmd>wincmd h<cr>", "Go to the left window" },
  ["<leader>j"] = { "<cmd>wincmd j<cr>", "Go to the down window" },
  ["<leader>k"] = { "<cmd>wincmd k<cr>", "Go to the up window" },
  ["<leader>l"] = { "<cmd>wincmd l<cr>", "Go to the right window" },
  ["<leader>c"] = { "+close window" },
  ["<leader>ch"] = { "<cmd>wincmd h<cr><cmd>close<cr>", "Close the left window" },
  ["<leader>cj"] = { "<cmd>wincmd j<cr><cmd>close<cr>", "Close the down window" },
  ["<leader>ck"] = { "<cmd>wincmd k<cr><cmd>close<cr>", "Close the up window" },
  ["<leader>cl"] = { "<cmd>wincmd l<cr>close<cr>", "Close the right window" },
  ["<leader>cc"] = { "<cmd>close<cr>", "Close the current window" },
  ["<leader>r"] = { "+resize window" },
  ["<leader>rk"] = { "<cmd>resize -5<cr>", "Expand window up" },
  ["<leader>rj"] = { "<cmd>resize +5<cr>", "Expand window bellow" },
  ["<leader>rl"] = { "<C-W>5>", "Expand window right" },
  ["<leader>rh"] = { "<C-W>5<", "Expand window left" },

  -- Tests (vim-test)
  ["<leader>t"] = { "+tests" },

  -- Buffers
  ["<leader>b"] = { "+buffers" },
  ["<leader>bd"] = { "<cmd>bdelete<cr>", "Delete the current buffer" },
  ["<leader>bn"] = { "<cmd>bnext<cr>", "Go to the next buffer" },
  ["<Tab>"] = { "<cmd>bnext<cr>", "Go to the next buffer" },
  ["<S-Tab>"] = { "<cmd>bnext<cr>", "Go to the next buffer" },
  ["<leader>bp"] = { "<cmd>bprev<cr>", "Go to the previous buffer" },

  -- Options
  ["<leader>o"] = { name = "+options" },
  ["<leader>op"] = { "<cmd>set paste! paste?<cr>", "Toggle &paste" },
  ["<leader>ol"] = { "<cmd>set list! list?<cr>", "Toggle &list" },
  ["<leader>ow"] = { "<cmd>set wrap! wrap?<cr>", "Toggle &wrap" },
  ["<leader>on"] = { "<cmd>lua require('tools.helpers').toggle_number()<cr>", "Toggle &number" },
  ["<leader>os"] = { "<cmd>set invhlsearch<cr>", "Toggle highlight for search results" },

  -- Operators
  ["Q"] = { name = "+format" },
  ["ys"] = { name = "+surroud" },
  ["gc"] = { name = "+comments" },

  -- Other
  ["gw"] = { "<cmd>lua require'tools.helpers'.vimgrep()<cr>", "Grep current word" },
  ["gI"] = { "`.", "Go to the last edit" },
  ["gk"] = { "k", "Up" },
  ["gj"] = { "j", "Down" },
  ["gM"] = {
    "<cmd>lua require'tools.helpers'.synstack()<cr>",
    "Show synstack for the current position",
  },
}

local cfg = require "config"
wk.register(cfg.keymaps)
