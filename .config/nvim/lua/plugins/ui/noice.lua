return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      view = "cmdline_popup", -- Display command line input in a floating popup window
      -- General options for all command line views
      opts = {
        size = {
          width = 100,
          height = "auto",
        },
        win_options = {
          -- Highlight group for the window itself and its border
          winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
      },
      format = {
        -- Default command line format
        cmdline = {
          title = " Command ",
          icon = ":", -- Custom icon for general commands
          lang = "vim", -- Syntax highlighting language
          icon_hl_group = "Normal", -- Highlight group for the icon
          opts = {
            position = {
              row = 5,
            },
          },
        },
        -- Format for searching downwards
        search_down = {
          kind = "search",
          pattern = "^/",
          icon = "/", -- Search icon with down arrow
          lang = "regex",
          icon_hl_group = "Normal",
          opts = {
            size = { width = "100%" }, -- Full width for search input
          },
        },
        -- Format for searching upwards
        search_up = {
          kind = "search",
          pattern = "^%?",
          icon = "?", -- Search icon with up arrow
          lang = "regex",
          icon_hl_group = "Normal",
          opts = {
            size = { width = "100%" },
          },
        },
        -- Format for shell commands initiated with `!`
        filter = {
          title = " Shell ",
          pattern = "^:%s*!",
          icon = "$",
          lang = "bash",
          icon_hl_group = "Normal",
        },
        -- Format for Lua commands
        lua = {
          pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
          icon = "lua",
          lang = "lua",
          icon_hl_group = "Normal",
        },
        -- Format for help commands
        help = { pattern = "^:%s*he?l?p?%s+", icon = "help", icon_hl_group = "Normal" },
        -- Format for generic input dialogs (e.g., `vim.ui.input()`)
        input = { view = "cmdline_input", icon = "input", icon_hl_group = "Normal" },
      },
    },
  },
}
