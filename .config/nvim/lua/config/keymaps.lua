local tools = require("tools") -- Assuming 'tools' module provides helper functions
local api = vim.api
local keymap = vim.keymap      -- Alias for vim.keymap.set

--- Global & Utility Mappings ---
-- Clear search highlights.
keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })
keymap.set("i", "<C-c>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-e><Esc>"
  else
    return "<Esc>"
  end
end, { expr = true, noremap = true, desc = "Exit insert mode or close completion menu" })

-- Delete character under cursor without copying it to register.
-- This prevents overwriting your paste buffer with single character deletes.
keymap.set("n", "x", '"_x', { desc = "Delete character under cursor without copying it", noremap = true, silent = true })

-- Global word replacement.
-- Prompts for a replacement, defaulting to the word under the cursor.
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace word under cursor globally" })

--- Window Splitting ---
keymap.set("n", "<C-s>", "<C-w>s", { desc = "Split window horizontally", noremap = true, nowait = true })
keymap.set("n", "<M-=>", "<C-w>=", { desc = "Make splits equal size", noremap = true, nowait = true })
keymap.set("n", "<M-,>", "<C-w><", { desc = "Decrease split width", noremap = true, nowait = true })
keymap.set("n", "<M-.>", "<C-w>>", { desc = "Increase split width", noremap = true, nowait = true })
keymap.set("n", "<M-->", "<C-w>-", { desc = "Decrease split height", noremap = true, nowait = true })
keymap.set("n", "<M-+>", "<C-w>+", { desc = "Increase split height", noremap = true, nowait = true })

--- General Navigation ---
-- Map 'k' and 'j' to 'gk' and 'gj' respectively.
-- This makes vertical movement consistent across wrapped and unwrapped lines.
keymap.set("n", "k", "gk", { desc = "Move cursor up (display line)" })
keymap.set("n", "j", "gj", { desc = "Move cursor down (display line)" })

-- Navigate through quickfix list (errors/warnings from `:make`, `:grep`)
keymap.set("n", "<left>", ":cprev<CR>zvzz", { desc = "Previous quickfix item (centered)" })
keymap.set("n", "<right>", ":cnext<CR>zvzz", { desc = "Next quickfix item (centered)" })

-- Navigate through location list (local to window, e.g., from `:lvimgrep`)
keymap.set("n", "<up>", ":lprev<CR>zvzz", { desc = "Previous loclist item (centered)" })
keymap.set("n", "<down>", ":lnext<CR>zvzz", { desc = "Next loclist item (centered)" })

-- When using '*', only highlight occurrences, do not jump to the next match.
keymap.set("n", "*", "*N", { desc = "Highlight all occurrences of word under cursor" })

-- Keep search results centered on the screen.
-- 'zz' centers the screen, 'zv' makes sure the cursor line is visible.
keymap.set("n", "n", "nzzzv", { desc = "Next search match (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search match (centered)" })

-- Preserve cursor position when joining lines.
-- 'mz' sets a mark 'z', 'J' joins, '`z' returns to mark 'z'.
keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

--- File Operations ---
-- Save the current file.
keymap.set("n", "<CR>", function()
  local buftype = vim.bo.buftype
  if buftype ~= "" then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
    return
  end
  vim.cmd "write"
  vim.notify("File saved", vim.log.levels.INFO)
end, { desc = "Save file" })

-- Fast save (assuming `tools.fast_save` handles this)
keymap.set("n", "<S-CR>", tools.fast_save, { desc = "Fast save (no prompts)" })

-- Quit Neovim
keymap.set("n", "<leader>qq", function()
  vim.cmd "qa" -- Quit all windows, no save prompts
end, { desc = "Quit Nvim" })

--- Command Mode ---
-- Command mode navigation
keymap.set("c", "<C-A>", "<Home>", { desc = "Go to beginning of command line" })
keymap.set("c", "<C-E>", "<End>", { desc = "Go to end of command line" })

--- Visual Mode ---
-- When pasting over a visual selection, don't copy the selected text into the default register.
-- "_d" deletes into the black hole register, "P" pastes before the cursor.
keymap.set("v", "p", '"_dP', { desc = "Paste without overwriting selection", noremap = true, silent = true })

--- Ex Mode ---
-- Disable Ex mode (`Q` key) and map it to `gq` (format lines).
-- This prevents accidental entry into the less commonly used Ex mode.
keymap.set("n", "Q", "gq", { desc = "Format lines (instead of Ex mode)" })

--- Terminal Mode ---
-- Exit terminal mode and return to Normal mode.
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- (Optional) If <C-[> is also used for escape:
-- keymap.set("t", "<C-[>", "<C-\\><C-n>")

--- User Commands ---
-- Define custom user commands for common tasks.
api.nvim_create_user_command("Make", "vsplit | :terminal make <args>",
  { nargs = "?", desc = "Run make in a new terminal split" })

-- Opens the dashboard (assuming MiniStarter is available)
api.nvim_create_user_command("Dashboard", function()
  -- Using pcall for robustness in case MiniStarter is not loaded
  local MiniStarter = require("mini.starter")
  if MiniStarter and MiniStarter.open then
    MiniStarter.open(0)
  else
    vim.notify("MiniStarter not available or not loaded.", vim.log.levels.WARN)
  end
end, { nargs = 0, desc = "Open the MiniStarter dashboard" })

-- Reloads Neovim configuration (assuming `tools.reload` handles this)
api.nvim_create_user_command("Reload", function(args)
  tools.reload(args.args)
end, { nargs = 1, desc = "Reload Neovim configuration" })

-- Define helper keymaps outside of which-key groups for direct access.
keymap.set("n", "<leader>on", tools.toggle_number, { desc = "Toggle line numbers" })
keymap.set("n", "gw", tools.vimgrep, { desc = "Grep word under cursor" })
keymap.set("n", "gM", tools.synstack, { desc = "Show syntax stack at cursor" })

--- Plugin Integrations (which-key) ---
-- Load which-key plugin, if available.
local ok, wk = pcall(require, "which-key")
if not ok then
  vim.notify("which-key plugin not found. Some keymaps may not be displayed.", vim.log.levels.WARN)
  return
end

-- Add keymaps to which-key for discoverability.
wk.add {
  -- Find something (prefix for various search/find commands)
  { "<leader>f",  group = "Find" },

  -- Plugins (prefix for plugin-related commands)
  { "<leader>p",  group = "Plugins" },

  -- Explore (prefix for various exploration/navigation tools)
  { "<leader>d",  group = "Explore" },
  { "<leader>dt", "<cmd>bo split | terminal<cr>",    desc = "Open terminal in new bottom split" },
  { "<leader>dl", "<cmd>lopen<cr>",                  desc = "Open location list" },
  { "<leader>dq", "<cmd>copen<cr>",                  desc = "Open quickfix list" },

  -- Git (fugitive plugin, or external commands)
  { "<leader>g",  group = "Git" },
  { "<leader>gh", "<cmd>!gh browse<cr>",             desc = "Browse current Git repo on GitHub" },

  { "<leader>c",  group = "Close Window" },
  { "<leader>ch", "<cmd>wincmd h<cr><cmd>close<cr>", desc = "Close left window" },
  { "<leader>cj", "<cmd>wincmd j<cr><cmd>close<cr>", desc = "Close down window" },
  { "<leader>ck", "<cmd>wincmd k<cr><cmd>close<cr>", desc = "Close up window" },
  { "<leader>cl", "<cmd>wincmd l<cr>close<cr>",      desc = "Close right window" },
  { "<leader>cc", "<cmd>close<cr>",                  desc = "Close current window" },

  -- Tests (often integrated with vim-test or similar plugins)
  { "<leader>t",  group = "Tests" },

  -- Buffer Management
  { "<leader>b",  group = "Buffers" },
  { "<leader>bd", "<cmd>bdelete<cr>",                desc = "Delete the current buffer" },
  { "<leader>bn", "<cmd>bnext<cr>",                  desc = "Go to next buffer" },
  { "<leader>bp", "<cmd>bprev<cr>",                  desc = "Go to previous buffer" },
  -- Note: <Tab> and <S-Tab> are mapped to next buffer. Consider if this conflicts with completion.
  { "<Tab>",      "<cmd>bnext<cr>",                  desc = "Go to next buffer (Tab)" },
  { "<S-Tab>",    "<cmd>bprev<cr>",                  desc = "Go to previous buffer (Shift+Tab)" }, -- Corrected S-Tab to bprev

  -- Options (toggle various Neovim options)
  { "<leader>o",  group = "Options" },
  { "<leader>ol", "<cmd>set list! list?<cr>",        desc = "Toggle list characters" },
  { "<leader>ow", "<cmd>set wrap! wrap?<cr>",        desc = "Toggle text wrapping" },
  { "<leader>on", tools.toggle_number,               desc = "Toggle line numbers" }, -- Duplicated, but useful for which-key display
  {
    "<leader>os",
    "<cmd>set invhlsearch<cr>",
    desc = "Toggle highlight for search results",
  },

  -- Other General Mappings (some are redundant with above, but explicit in which-key)
  { "gw", tools.vimgrep,  desc = "Grep current word (from tools)" },
  { "gI", "`.",           desc = "Go to the last edit position" },
  { "gk", "k",            desc = "Move up (original 'k' behavior)" },   -- Redundant if k=gk is set globally
  { "gj", "j",            desc = "Move down (original 'j' behavior)" }, -- Redundant if j=gj is set globally
  { "gM", tools.synstack, desc = "Show syntax stack at current position (from tools)" },
}

-- Load additional keymaps from a configuration module, if provided.
local cfg = require("config")
if cfg and cfg.keymaps then
  wk.add(cfg.keymaps)
end
