local opt = vim.opt -- for options (set)
local fn = vim.fn   -- for vim's built-in functions (stdpath, mkdir, etc.)

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- UI / Appearance
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.termguicolors = true  -- Enable 24-bit True Color support
opt.cursorline = true     -- Highlight the current line
opt.showmode = false      -- Disable the default mode indicator
opt.laststatus = 2        -- Always show the statusline
opt.winborder = 'rounded' -- Use rounded borders for floating windows
opt.conceallevel = 2      -- Hide concealed text unless it has a custom replacement character
opt.listchars = { tab = '⇥ ', trail = '·', extends = '⋯', precedes = '⋯', eol = '$', nbsp = '~' }

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Line Numbers
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.number = true
opt.numberwidth = 2
opt.signcolumn = 'number'

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Behavior
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.clipboard = 'unnamedplus'     -- Use the system clipboard
opt.confirm = true                -- Prompt to save unsaved changes when exiting
opt.virtualedit = 'all'           -- Allow the cursor to move into "virtual" space
opt.whichwrap = 'b,s,<,>,[,],l,h' -- Allow <Left>/<Right> to cross line boundaries
opt.showmatch = true              -- Show matching brackets
opt.matchpairs:append('<:>')      -- Add <> to the list of matchable pairs

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Completion
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.autocomplete = true
opt.complete = { 'o', '.' } -- Omni completion and completion from the current buffer
opt.pumborder = 'rounded'
opt.pumheight = 10          -- Limit the height of the popup menu
-- menuone - Use the popup menu even if there is only one match
-- noselect - Do not automatically select a match in the popup menu
opt.completeopt = { 'menuone', 'noselect', 'popup', 'nosort' }
opt.infercase = true -- Automatically adjust case on completion

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Indentation
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.expandtab = true   -- Use spaces instead of tabs
opt.tabstop = 2        -- Number of visual spaces per tab
opt.shiftwidth = 2     -- Number of spaces to use for auto-indent
opt.softtabstop = 2    -- Number of spaces for a <Tab> press in insert mode
opt.smartindent = true -- Enable smart auto-indenting
opt.shiftround = true  -- Round indent to the nearest 'shiftwidth'

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Wrapping & Scrolling
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.linebreak = true   -- Wrap lines at word boundaries instead of characters
opt.scrolloff = 4      -- Keep at least 4 lines visible above/below the cursor
opt.sidescrolloff = 10 -- Same for horizontal scrolling

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Searching
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true  -- But, if the search pattern contains uppercase, be case-sensitive
opt.path = '**'       -- Allow searching in all subdirectories for file-finding commands

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Window Management
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits to the bottom
opt.winminheight = 0  -- Allow windows to shrink to 0 lines
opt.winminwidth = 0   -- Allow windows to shrink to 0 columns

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Files / Backup
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.backup = false      -- Do not create a backup file
opt.writebackup = false -- Do not write to a backup file
opt.swapfile = false    -- Do not create a swapfile

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Undo
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.undofile = true -- Enable persistent undo
opt.undodir = fn.expand('~/.cache/nvim/undo')

local undodir = opt.undodir:get()[1] -- Get the first path in the undodir list
if not fn.isdirectory(undodir) then
  fn.mkdir(undodir)                  -- Create the undo directory if it doesn't exist
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Timing
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.timeoutlen = 500  -- Time to wait for a mapped sequence to complete
opt.ttimeoutlen = 500 -- Time to wait for a terminal key code to complete

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Diagnostics
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = { source = true, prefix = '' },
  jump = { float = true },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.INFO },
  },
})

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Folding
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

opt.foldlevel = 99 -- Start with all folds open
