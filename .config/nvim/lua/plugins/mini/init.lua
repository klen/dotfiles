-- Install the mini base
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim' }
})

-- Plugins
require('plugins/mini/clue')       -- Keybinding hints
require('plugins/mini/comment')    -- Commenting
require('plugins/mini/files')      -- File explorer
require('plugins/mini/pairs')      -- Auto-close pairs of characters
require('plugins/mini/statusline') -- Statusline
require('plugins/mini/surround')   -- Surround text objects

-- require('plugins/mini/bufremove')  -- Buffer management
-- require('plugins/mini/starter')    -- Start screen
