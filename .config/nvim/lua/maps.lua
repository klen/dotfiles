local u = require "utils"

g.mapleader = ","
g.maplocalleader = " "

-- Navigation
u.nmap("j", "gj")
u.nmap("k", "gk")
u.nmap("<left>", ":cprev<cr>zvzz") -- quickfix
u.nmap("<right>", ":cnext<cr>zvzz")
u.nmap("<up>", ":lprev<cr>zvzz") -- loclist
u.nmap("<down>", ":lnext<cr>zvzz")

-- Automatically jump to end of text you pasted
u.nmap("p", "p`]")
u.vmap("p", "p`]")
u.vmap("y", "y`]")

-- Not jump on star, only highlight
u.nmap("*", "*N")

-- Keep it centered
u.nmap("n", "nzzzv")
u.nmap("N", "Nzzzv")
u.nmap("J", "mzJ`z")

-- use ESC to turn off search highlighting
u.nmap("<Esc>", ":noh<CR>")
-- u.nmap('<Esc>', ':set invhlsearch<CR>')

-- Save file
u.nmap("<CR>", ":w<CR>")

-- Toggle keymap
u.nmap("<C-F>", "a<C-^><Esc>")
u.imap("<C-F>", "<C-^>")
u.vmap("<C-F>", "<Esc>a<C-^><Esc>gv")

-- Command mode
u.cmap("<C-A>", "<Home>", { silent = false })
u.cmap("<C-E>", "<End>", { silent = false })

-- Paste relaces visual selection do not copy it
u.vmap("p", '"_dP')

-- Terminal mode
u.tmap("<C-[>", "<C-\\><C-n>")

--  Commands
--  --------

u.command("-nargs=0 Reset", "write | :edit")
u.command("-nargs=0 Remove", "call delete(expand('%')) | bdelete")
u.command("-nargs=? Make", "vsplit | :terminal make <args>")
u.lua_command("Dashboard", "MiniStarter.open()")
u.lua_command("-nargs=1 Reload", "require'plenary.reload'.reload_module(fn.expand('<args>'))")

-- Plugins
local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

wk.register {

  -- File operations (telescope, nvim-tree)
  ["<leader>f"] = { name = "+file" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fp"] = { "<cmd>Telescope projects<cr>", "Open projects" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fw"] = { "<cmd>Telescope live_grep<cr>", "Find Word" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },

  ["<leader>d"] = { name = "+explore" },
  ["<leader>dd"] = { "<cmd>NvimTreeFocus<cr>", "Open/focus Explorer" },
  ["<leader>df"] = { "<cmd>NvimTreeFindFile<cr>", "Locate File" },
  ["<leader>db"] = { "<cmd>Telescope buffers<cr>", "Open dashboard" },
  ["<leader>ds"] = { "<cmd>Dash<cr>", "Search in dash" },
  ["<leader>dw"] = { "<cmd>DashWord<cr>", "Search current word in dash" },
  ["<leader>dt"] = { "<cmd>vsplit | terminal<cr>", "Open terminal" },
  ["<leader>dl"] = { "<cmd>lopen<cr>", "Open loclist" },
  ["<leader>dq"] = { "<cmd>copen<cr>", "Open quickfix" },

  -- Git (fugitive)
  ["<leader>g"] = { name = "+git" },
  ["<leader>ga"] = { "<cmd>Gwrite<cr>", "Git add" },
  ["<leader>gb"] = { "<cmd>Git blame<cr>", "Git blame" },
  ["<leader>gd"] = { "<cmd>Gdiffsplit<cr>", "Git diff" },
  ["<leader>gs"] = { "<cmd>Git<cr>", "Git status" },
  ["<leader>gr"] = { "<cmd>Gdelete<cr>", "Git remove" },
  ["<leader>gp"] = { "<cmd>Git push<cr>", "Git push all" },
  ["<leader>gc"] = { "<cmd>Git commit %<cr>", "Git commit" },
  ["<leader>gl"] = { "<cmd>Telescope git_bcommits<cr>", "Git log file" },
  ["<leader>gL"] = { "<cmd>Telescope git_commits<cr>", "Git log" },

  -- Comments
  ["gc"] = { "+comments" },
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

  -- Tests (vim-test)
  ["<leader>t"] = { "+tests" },
  ["<leader>tn"] = { "<cmd>TestNearest<cr>", "Run the nearest test" },
  ["<leader>tf"] = { "<cmd>TestFile<cr>", "Run the file" },
  ["<leader>tt"] = { "<cmd>TestFile<cr>", "Run all tests" },
  ["<leader>tl"] = { "<cmd>TestLast<cr>", "Run the last test" },
  ["<leader>tv"] = { "<cmd>TestVisit<cr>", "Visit the last test" },

  -- Buffers
  ["<leader>b"] = { "+buffers" },
  ["<leader>bd"] = { "<cmd>bdelete<cr>", "Delete the current buffer" },
  ["<leader>bn"] = { "<cmd>bnext<cr>", "Go to the next buffer" },
  ["<leader>bp"] = { "<cmd>bprev<cr>", "Go to the previous buffer" },

  -- Options
  ["<leader>o"] = { name = "+options" },
  ["<leader>op"] = { "<cmd>set paste! paste?<cr>", "Toggle &paste" },
  ["<leader>ol"] = { "<cmd>set list! list?<cr>", "Toggle &list" },
  ["<leader>ow"] = { "<cmd>set wrap! wrap?<cr>", "Toggle &wrap" },
  ["<leader>on"] = { "<cmd>lua require('utils.tools').toggle_number()<cr>", "Toggle &number" },
  ["<leader>os"] = { "<cmd>set invhlsearch<cr>", "Toggle highlight for search results" },

  -- Other
  ["gw"] = { "<cmd>lua require'utils.tools'.vimgrep()<cr>", "Grep current word" },
  ["gI"] = { "`.", "Go to the last edit" },
  ["gk"] = { "k", "Up" },
  ["gj"] = { "j", "Down" },
}
