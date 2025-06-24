-- [[ 0. Aliases ]]
-- For convenience and brevity, create local aliases for common APIs
local opt = vim.opt -- for options (set)
local g = vim.g     -- for global variables (let g:)
local fn = vim.fn   -- for vim's built-in functions (stdpath, mkdir, etc.)

---------------------------------------------------------------------------------

-- [[ 1. Core Behavior ]]

g.mapleader = ","      -- Set the global leader key
g.maplocalleader = " " -- Set the buffer-local leader key

---------------------------------------------------------------------------------

-- [[ 2. Visuals & Interface ]]

-- Enable 24-bit True Color support
opt.termguicolors = true
-- Show the file name in the window title
opt.title = true
-- Show line numbers
opt.number = true
opt.numberwidth = 2
-- Highlight the current line
opt.cursorline = true
-- Disable the default mode indicator (e.g., -- INSERT --), as it's redundant with a statusline
opt.showmode = false
opt.laststatus = 3 -- Always show the statusline
-- Disable the nvim intro message
opt.shortmess:append("sI")

-- Configure how special characters are displayed
opt.listchars = { tab = '⇥ ', trail = '·', extends = '⋯', precedes = '⋯', eol = '$', nbsp = '~' }

-- Set a virtual color column to fix a bug with some plugins like indent-blankline
opt.colorcolumn = '9999'

---------------------------------------------------------------------------------

-- [[ 3. Editing Experience ]]

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

-- Completion
opt.completeopt = 'menu,menuone,noselect'

-- Bracket/Pair Matching
opt.showmatch = true         -- Show matching brackets
opt.matchpairs:append('<:>') -- Add <> to the list of matchable pairs

-- Misc Editing
opt.virtualedit = 'all' -- Allow the cursor to move into "virtual" space

---------------------------------------------------------------------------------

-- [[ 4. Files & System ]]

-- Configure swap, and persistent undo files
opt.swapfile = false
opt.undofile = true -- Enable persistent undo
opt.undodir = fn.expand('~/.cache/nvim/undo')

local undodir = opt.undodir:get()[1] -- Get the first path in the undodir list
if not fn.isdirectory(undodir) then
  fn.mkdir(undodir)                  -- Create the undo directory if it doesn't exist
end

-- Use the system clipboard
opt.clipboard = 'unnamedplus'

-- Prompt to save unsaved changes when exiting
opt.confirm = true

-- Security setting, should be one of the last
opt.secure = true

---------------------------------------------------------------------------------

-- [[ 5. Windows & Splits ]]

-- Open new splits to the right and bottom
opt.splitright = true
opt.splitbelow = true

-- Set minimum window height and width
opt.winminheight = 0
opt.winminwidth = 0

---------------------------------------------------------------------------------

-- [[ 6. Localization & Encoding ]]

-- Set default encodings
opt.fileencodings = 'utf-8'

-- Support for bidirectional text (for Arabic, Hebrew)
opt.termbidi = true

---------------------------------------------------------------------------------

-- [[ 7. Performance & Misc ]]

-- Set timeout lengths
opt.timeoutlen = 500  -- Time to wait for a mapped sequence to complete
opt.ttimeoutlen = 500 -- Time to wait for a terminal key code to complete

-- Folding settings
opt.foldlevel = 99
opt.foldlevelstart = 99

-- Don't use octal/hex formats for CTRL-A/CTRL-X number operations
opt.nrformats = ''

-- Disable the built-in editorconfig plugin if you manage settings elsewhere
g.editorconfig = false
