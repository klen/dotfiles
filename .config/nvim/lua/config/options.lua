local opt = vim.opt           -- for options (set)
local fn = vim.fn             -- for vim's built-in functions (stdpath, mkdir, etc.)

opt.termguicolors = true      -- Enable 24-bit True Color support
opt.cursorline = true         -- Highlight the current line
opt.showmode = false          -- Disable the default mode indicator
opt.laststatus = 2            -- Always show the statusline
opt.virtualedit = 'all'       -- Allow the cursor to move into "virtual" space
opt.confirm = true            -- Prompt to save unsaved changes when exiting
opt.clipboard = 'unnamedplus' -- Use the system clipboard
opt.winborder = 'rounded'     -- Use rounded borders for floating windows
opt.conceallevel = 2          -- Hide concealed text unless it has a custom replacement character

-- Autocomplete
opt.autocomplete = true
opt.complete = { 'o', '.' } -- Omni completion and completion from the current buffer
opt.pumborder = 'rounded'
opt.pumheight = 10          -- Limit the height of the popup menu
-- menuone - Use the popup menu even if there is only one match
-- noselect - Do not automatically select a match in the popup menu
opt.completeopt = { 'menuone', 'noselect', 'popup', 'nosort' }

-- Configure how special characters are displayed
opt.listchars = { tab = '⇥ ', trail = '·', extends = '⋯', precedes = '⋯', eol = '$', nbsp = '~' }

-- Line Numbers
opt.number = true
opt.numberwidth = 2
opt.signcolumn = "number"

-- Indentation
opt.expandtab = true   -- Use spaces instead of tabs
opt.tabstop = 2        -- Number of visual spaces per tab
opt.shiftwidth = 2     -- Number of spaces to use for auto-indent
opt.softtabstop = 2    -- Number of spaces for a <Tab> press in insert mode
opt.smartindent = true -- Enable smart auto-indenting
opt.shiftround = true  -- Round indent to the nearest 'shiftwidth'

-- Wrapping & Scrolling
opt.linebreak = true              -- Wrap lines at word boundaries instead of characters
opt.whichwrap = 'b,s,<,>,[,],l,h' -- Allow <Left>/<Right> to cross line boundaries
opt.scrolloff = 4                 -- Keep at least 4 lines visible above/below the cursor
opt.sidescrolloff = 10            -- Same for horizontal scrolling

-- Searching
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true  -- But, if the search pattern contains uppercase, be case-sensitive
opt.infercase = true  -- Automatically adjust case on completion
opt.path = '**'       -- Allow searching in all subdirectories for file-finding commands

-- Bracket/Pair Matching
opt.showmatch = true         -- Show matching brackets
opt.matchpairs:append('<:>') -- Add <> to the list of matchable pairs

-- Open new splits to the right and bottom
opt.splitright = true
opt.splitbelow = true

-- Set minimum window height and width
opt.winminheight = 0
opt.winminwidth = 0

-- Backup
opt.backup = false      -- do not create a backup file
opt.writebackup = false -- do not write to a backup file
opt.swapfile = false    -- do not create a swapfile

-- Undo
opt.undofile = true -- Enable persistent undo
opt.undodir = fn.expand('~/.cache/nvim/undo')

local undodir = opt.undodir:get()[1] -- Get the first path in the undodir list
if not fn.isdirectory(undodir) then
  fn.mkdir(undodir)                  -- Create the undo directory if it doesn't exist
end

-- Set timeout lengths
opt.timeoutlen = 500  -- Time to wait for a mapped sequence to complete
opt.ttimeoutlen = 500 -- Time to wait for a terminal key code to complete

-- Diagnostic
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = { source = true, prefix = '' },
  jump = { float = true },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.INFO },
  }
})

-- Folding
vim.opt.foldlevel = 99 -- Start with all folds open
